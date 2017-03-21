//
//  iPodAssistant.m
//  GameTem
//
//  Created by longminghong on 17/3/17.
//  Copyright © 2017年 longminghong. All rights reserved.
//

#import "iPodAssistant.h"
#import <MediaPlayer/MediaPlayer.h>

@interface iPodAssistant(){

    MPMusicPlayerController* musicPlayer_;
}
@property (nonatomic,strong) MPMusicPlayerController* musicPlayer;

@end

@implementation iPodAssistant
@synthesize musicPlayer = musicPlayer_;

- (MPMusicPlayerController *)musicPlayer{
    
    if (nil == musicPlayer_) {
        musicPlayer_ = [MPMusicPlayerController systemMusicPlayer];
    }
    return musicPlayer_;
}


/**
 before you call this iPodTrackChangeNoticeRegister() function,make sure you register notificationCenter.
  
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iPodPlayingChanged:) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
 
 */
- (void)iPodTrackChangeNoticeRegister {
    
    [self.musicPlayer beginGeneratingPlaybackNotifications];
}

- (NSDictionary *)getiPodCurrentlyPlaying{

    NSDictionary *result;
    @try {
        
        MPMediaItem* currentTrack = self.musicPlayer.nowPlayingItem;
        
        NSString* title = [currentTrack valueForProperty:MPMediaItemPropertyTitle];
        NSString* artist = [currentTrack valueForProperty:MPMediaItemPropertyArtist];
        
        NSString* album = [currentTrack valueForProperty:MPMediaItemPropertyAlbumTitle];
        
        result = [[NSDictionary alloc]initWithObjects:@[@"title",@"artist",@"album"] forKeys:@[title,artist,album]];
        
    } @catch (NSException *exception) {
        
        NSLog(@"%s,%s",__FILE__,__FUNCTION__);
        
    } @finally {
        
        return result;
    }
}

#pragma mark -
#pragma mark iPod controls

- (void)play{

  // Start playing
[self.musicPlayer play];  
}

- (void)pause{

    // Stop playing, but remember the current playback position
    [self.musicPlayer pause];
}

- (void)stop{
    
    // Stop playing
    [self.musicPlayer stop];
}

- (void)skipToBeginning{

    // Go back to the start of the current item
    [self.musicPlayer skipToBeginning];
}

- (void)skipToNextItem{

    // Go to the start of the next item
    [self.musicPlayer skipToNextItem];
}

- (void)skipToPreviousItem{
    
    // Go to the start of the previous item
    [self.musicPlayer skipToPreviousItem];
}

- (void)beginSeekingForward{

    // Start playing in fast-forward (use "play" to resume playback)
    [self.musicPlayer beginSeekingForward];
}

- (void)beginSeekingBackward{

    // Start playing in fast-reverse.
    [self.musicPlayer beginSeekingBackward];
}

#pragma mark -
#pragma mark iPod controls



@end
