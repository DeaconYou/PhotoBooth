//
//  AsyncOperationManager.h
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsyncOperationManager : NSObject

+ (instancetype)sharedInstance;

// Prohibit outside init and copy
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;
- (id)mutableCopy NS_UNAVAILABLE;

- (void)addOperationWithBlock:(void (^)(void))task andKey:(NSString *)key;

- (void)cancelOperationIfNeededWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
