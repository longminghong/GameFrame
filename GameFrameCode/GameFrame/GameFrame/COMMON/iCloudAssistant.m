//
//  iCloudAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/17.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "iCloudAssistant.h"

NSMetadataQuery* _query; // Keep this around in an instance variable

@implementation iCloudAssistant

+ (BOOL)iCoudAvailable{
    
    BOOL hasiCloudAvailable = NO;
    
    if ([[NSFileManager defaultManager] ubiquityIdentityToken] == nil) {
        // iCloud is unavailable. You'll have to store the saved game locally.
        
        hasiCloudAvailable = NO;
    }else{
        hasiCloudAvailable = YES;
    }
    return hasiCloudAvailable;
}


#pragma mark -
#pragma mark upload a file in iCloud.

- (void)iCloudUploadFile{
    
    NSString* fileName = @"MySaveGame.save"; // this can be anything
    
    // Moving into iCloud should always be done in a background queue, because it
    // can take a bit of time
    
    NSURL *saveGameURL;// this url should be the one, you save in local.
    
    NSOperationQueue* backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        NSURL* containerURL = [[NSFileManager defaultManager]
                               URLForUbiquityContainerIdentifier:nil];
        NSURL* iCloudURL = [containerURL URLByAppendingPathComponent:fileName];
        NSError* error = nil;
        [[NSFileManager defaultManager] setUbiquitous:YES itemAtURL:saveGameURL
                                       destinationURL:iCloudURL error:&error];
        if (error != nil) {
            NSLog(@"Problem putting the file in iCloud: %@", error);
        }
    }];
}


/**
 
 iCloudSearchFile()
 
 To find files that are in iCloud, you use the NSMetadataQuery class.
 NSMetadataQuery works like a search
 
 @param fileName The file name you would like to find.
 */
- (void)iCloudSearchFile:(NSString *)fileName{
    
    _query = [[NSMetadataQuery alloc] init];
    
    [_query setSearchScopes:[NSArray arrayWithObjects:NSMetadataQueryUbiquitousDocumentsScope, nil]];
    
    // Search for all files ending in .save
    [_query setPredicate:[NSPredicate predicateWithFormat:@"%K LIKE '*.save'",
                          NSMetadataItemFSNameKey]];
    
    // Register to be notified of when the search is complete
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter]; [notificationCenter addObserver:self selector:@selector(searchComplete)
                                                                                                                name:NSMetadataQueryDidFinishGatheringNotification object:nil]; [notificationCenter addObserver:self selector:@selector(searchComplete)
                                                                                                                                                                                                           name:NSMetadataQueryDidUpdateNotification object:nil];
    [_query startQuery];
}

- (void)searchComplete {
    
    for (NSMetadataItem* item in _query.results) {
        // Find the URL for the item
        NSURL* url = [item valueForAttribute:NSMetadataItemURLKey];
        
        if ([item valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey] ==
            NSMetadataUbiquitousItemDownloadingStatusCurrent) {
            // This file is downloaded and is the most current version
            
//            [self doSomethingWithURL:url];
        }else{
                // The file is either not downloaded at all, or is out of date
                // We need to download the file from iCloud; when it finishes
                // downloading, NSMetadataQuery will call this method again
                NSError* error = nil;
            
                [[NSFileManager defaultManager] startDownloadingUbiquitousItemAtURL:url error:&error];
                if (error != nil) {
                    
                    NSLog(@"Problem starting download of %@: %@", url, error);
                }
        }
    }
}

- (void)iCloudStopSearching{
    
    [_query stopQuery];
}

#pragma mark -
#pragma mark conflict detect & solved..

//If the same file is changed at the same time by different devices, the file will be in conflict

- (BOOL)iCloudConflictDetectPass:(NSMetadataItem *)item{

    if ([item valueForAttribute:NSMetadataUbiquitousItemHasUnresolvedConflictsKey]) {
    
        // there is a conflict.
        
        return YES;
    }
    
    return NO;
}

- (void)iCloudConflictSolved{

    // Run this code when an NSMetadataQuery indicates that a file is in conflict
    NSURL* fileURL ; // the URL of the file that has conflicts to be resolved
    for (NSFileVersion* conflictVersion in [NSFileVersion unresolvedConflictVersionsOfItemAtURL:fileURL]) {
        conflictVersion.resolved = YES;
    }
    [NSFileVersion removeOtherVersionsOfItemAtURL:fileURL error:nil];
}

#pragma mark -
#pragma mark Key/Value store.

// Use NSUbiquitousKeyValueStore, which is like an NSMutableDictionary whose contents are shared across all of the user’s devices
//The ubiquitous key/value store stores small amounts of data—strings, numbers, and so on—and keeps them synchronized.
// you should keep data in the local user defaults, and update it only after comparing it to the ubiquitous store
// You’re limited to 1 MB of data in the ubiquitous key/value store on a per-application basis.

- (void)iCloudStore{

    NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore]; // Get the most recent level
    
    int mostRecentLevel = (int)[store longLongForKey:@"mostRecentLevel"]; // Save the level

    [store setLongLong:13 forKey:@"mostRecentLevel"];
    
    // Sign up to be notified of when the store changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeUpdated:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:store];
}

- (void) storeUpdated:(NSNotification*)notification {
    NSArray* listOfChangedKeys = [notification.userInfo
                                  objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
    
    NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore]; // Get the most recent level
    for (NSString* changedKey in listOfChangedKeys) {
        
        NSLog(@"%@ changed to %@", changedKey, [store objectForKey:changedKey]);
    }
}

#pragma mark -
#pragma mark saveing structure information
//  JSON can only store specific kinds of data

/**
 • Strings
 • Numbers
 • Boolean values (i.e., true and false)
 • Arrays
 • Dictionaries (JSON calls these “objects”)
 */

- (void)iCloudSaveStructureInformation:(NSDictionary *)info{

    NSDictionary* informationToSave = @{
                                        @"playerName": @"Grabthar",
                                        @"weaponType": @"Hammer",
                                        @"hitPoints": @1000,
                                        @"currentQuests": @[@"save the universe", @"get home"]
                                        };
    
    NSError* error = nil;
    
    BOOL canBeConverted = [NSJSONSerialization isValidJSONObject:informationToSave];
    if (NO == canBeConverted) {
        return;
    }
    NSData* dataToSave = [NSJSONSerialization dataWithJSONObject:informationToSave
                                                         options:0 error:&error];
    NSLog(@"Error converting data to JSON: %@", error);
    if (error != nil) {
    }
    NSURL *locationToSaveTo;
    [dataToSave writeToURL:locationToSaveTo atomically:YES];
    
    
    
    NSURL *locationToLoadFrom;
    NSData* loadedData = [NSData dataWithContentsOfURL:locationToLoadFrom];
    if (loadedData == nil) {
        NSLog(@"Error loading data: %@", error);
    }
    NSDictionary* loadedDictionary = [NSJSONSerialization
                                      JSONObjectWithData:loadedData options:0 error:&error];
    if (loadedDictionary == nil) {
        NSLog(@"Error processing data: %@", error);
    }
    // ALWAYS ensure that the data that you've received is the type you expect:
    if ([loadedData isKindOfClass:[NSDictionary class]] == NO) { NSLog(@"Error: loaded data is not what I expected!");
    }
    
}
@end
