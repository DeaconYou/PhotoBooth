//
//  ViewModelManager.h
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModelManager : NSObject

+ (instancetype)sharedInstance;

// Prohibit outside init and copy
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;
- (id)mutableCopy NS_UNAVAILABLE;

- (void)savePhoto:(PhotoViewModel *)photoViewModel;

- (NSArray *)getAllPhotos;

- (NSArray *)getPhotosWithPageNum:(int)pageNum andRowsPerPage:(int)rowsPerPage;

- (UIImage *)getPhotoImageWithFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
