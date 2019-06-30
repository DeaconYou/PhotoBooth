//
//  FileManager.h
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileManager : NSObject

+ (instancetype)sharedInstance;

// Prohibit outside init and copy
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;
- (id)mutableCopy NS_UNAVAILABLE;

- (void)saveImage:(UIImage *)image withFileName:(NSString *)fileName;

- (UIImage *)getImageWithFileName:(NSString *)fileName;

- (void)createDirectoryIfNotExists:(NSString *)directory;

@end

NS_ASSUME_NONNULL_END
