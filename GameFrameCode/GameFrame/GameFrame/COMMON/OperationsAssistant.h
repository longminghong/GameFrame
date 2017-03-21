//
//  OperationsAssistant.h
//  GameTem
//
//  Created by longminghong on 17/3/15.
//  Copyright © 2017年 longminghong. All rights reserved.
//

//默认下,批量操作协助这里可以支持5个任务并发,你也可以手动修改并发数。
//支持后台任务并发用于处理静默式任务,和优先任务并发处理界面优先任务。
//这里也提供了依赖性任务的实现例子和延迟执行的例子。


#import <Foundation/Foundation.h>

@interface OperationsAssistant : NSObject

- (instancetype)init;

- (void)setMaxOprationCount:(NSInteger)count;

- (void)dependentOperations:(NSArray *)array;

- (void)addBackgroundOperationTarget:(id)target selector:(SEL)selector;

- (void)addBackgroundOperationWithInvocation:(NSInvocation *)invocation;

- (void)addPriorityOperationTarget:(id)target selector:(SEL)selector;

- (void)addPriorityOperationWithInvocation:(NSInvocation *)invocation;
    
@end
