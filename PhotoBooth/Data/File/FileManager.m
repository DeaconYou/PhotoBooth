//
//  FileManager.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (instancetype)sharedInstance{
    static FileManager *_sharedInstance = nil;
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
        [self createDirectoryIfNotExists:[self getImageDirectory]];
    }
    return self;
}

- (NSString *)getImageDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *imageDirectory = [documentPath stringByAppendingString:@"/photoBoothImages"];
    return imageDirectory;
}

- (NSString *)getImagePathWithFileName:(NSString *)fileName{
    NSString *imagePath = [[self getImageDirectory] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", fileName]];
    
    return imagePath;
}

- (void)saveImage:(UIImage *)image withFileName:(NSString *)fileName{
    [UIImagePNGRepresentation(image) writeToFile:[self getImagePathWithFileName:fileName] atomically:YES];
}

- (UIImage *)getImageWithFileName:(NSString *)fileName{
    return [UIImage imageWithContentsOfFile:[self getImagePathWithFileName:fileName]];
}

- (void)createDirectoryIfNotExists:(NSString *)directory{
    
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:directory];
    
    if(!existed){
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
