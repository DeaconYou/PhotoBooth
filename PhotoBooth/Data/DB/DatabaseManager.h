//
//  DatabaseManager.h
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseManager : NSObject

+ (instancetype)sharedInstance;

// Prohibit outside init and copy
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (id)copy NS_UNAVAILABLE;
- (id)mutableCopy NS_UNAVAILABLE;

- (BOOL)insertPhoto:(Photo *)photo;

- (NSArray *)selectPhotosWithPageNum:(int)pageNum andRowsPerPage:(int)rowsPerPage;

- (NSArray *)selectAllPhotos;

- (BOOL)deletePhoto:(Photo *)photo;

@end

NS_ASSUME_NONNULL_END
