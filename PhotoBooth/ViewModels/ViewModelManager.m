//
//  ViewModelManager.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "ViewModelManager.h"
#import "../Data/DataSourceManager.h"

@implementation ViewModelManager

+ (instancetype)sharedInstance{
    static ViewModelManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)savePhoto:(PhotoViewModel *)photoViewModel{
    Photo *photo = [[Photo alloc]init];
    photo.name = photoViewModel.name;
    photo.createdTimestamp = photoViewModel.createdTimestamp;
    [[DataSourceManager sharedInstance] savePhoto:photo withImage:photoViewModel.image];
}

- (NSArray *)getAllPhotos{
    return [self getPhotosWithPageNum:-1 andRowsPerPage:-1];
}

- (NSArray *)getPhotosWithPageNum:(int)pageNum andRowsPerPage:(int)rowsPerPage{
    NSMutableArray *photoViewModels = [[NSMutableArray alloc]init];
    
    NSArray *photos = [[DataSourceManager sharedInstance] getPhotosWithPageNum:pageNum andRowsPerPage:rowsPerPage];
    for (Photo *photo in photos) {
        PhotoViewModel *photoViewModel = [[PhotoViewModel alloc]init];
        photoViewModel.name = photo.name;
        photoViewModel.createdTimestamp = photo.createdTimestamp;
        [photoViewModels addObject:photoViewModel];
    }
    
    return photoViewModels;
}

- (UIImage *)getPhotoImageWithFileName:(NSString *)fileName{
    return [[DataSourceManager sharedInstance] getImageWithFileName:fileName];
}

@end
