//
//  AsyncOperationManager.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "AsyncOperationManager.h"

@interface AsyncOperationManager ()

@property (strong, nonatomic) NSOperationQueue *operationQueue;

@property (strong, nonatomic) NSMutableDictionary *operationDict;

@end

@implementation AsyncOperationManager

+ (instancetype)sharedInstance{
    static AsyncOperationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationDict = [[NSMutableDictionary alloc]init];
        _operationQueue = [[NSOperationQueue alloc]init];
        [_operationQueue setMaxConcurrentOperationCount:8];
    }
    return self;
}

- (void)addOperationWithBlock:(void (^)(void))task andKey:(NSString *)key{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        if(task){
            task();
        }
        [self.operationDict removeObjectForKey:key];
    }];
    
    NSArray *operations = [_operationQueue operations];
    
    if(operations && operations.count > 0){
        [((NSOperation *)(operations.lastObject)) addDependency:operation];
    }
    
    [_operationQueue addOperation:operation];
    
    [_operationDict setObject:operation forKey:key];
}

-(void)cancelOperationIfNeededWithKey:(NSString *)key{
    NSOperation *operation = (NSOperation *)[_operationDict objectForKey:key];
    if(operation && !operation.isCancelled){
        [operation cancel];
        [self.operationDict removeObjectForKey:key];
    }
}

@end
