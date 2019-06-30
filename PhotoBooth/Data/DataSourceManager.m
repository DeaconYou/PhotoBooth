//
//  DataSourceManager.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "DataSourceManager.h"
#import "DB/DatabaseManager.h"
#import "File/FileManager.h"

@implementation DataSourceManager

+ (instancetype)sharedInstance{
    static DataSourceManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)savePhoto:(Photo *)photo withImage:(UIImage *)image{
    [[DatabaseManager sharedInstance] insertPhoto:photo];
    [[FileManager sharedInstance] saveImage:image withFileName:[NSString stringWithFormat:@"%f", photo.createdTimestamp]];
}

- (NSArray *)getAllPhotos{
    return [[DatabaseManager sharedInstance]selectAllPhotos];
}

- (NSArray *)getPhotosWithPageNum:(int)pageNum andRowsPerPage:(int)rowsPerPage{
    return [[DatabaseManager sharedInstance]selectPhotosWithPageNum:pageNum andRowsPerPage:rowsPerPage];
}

- (UIImage *)getImageWithFileName:(NSString *)fileName{
    return [[FileManager sharedInstance] getImageWithFileName:fileName];
}

@end
