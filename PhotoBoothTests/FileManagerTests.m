//
//  PhotoBoothTests.m
//  PhotoBoothTests
//
//  Created by Deacon You on 2019/7/1.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "../PhotoBooth/Data/File/FileManager.h"

@interface FileManagerTests : XCTestCase

@property (copy, nonatomic) NSString *testImageFileName;

@end

@implementation FileManagerTests

- (void)setUp {
    _testImageFileName = @"TestImageFileName";
}

- (void)tearDown {
    NSString * imageFilePath = [[FileManager sharedInstance] getImagePathWithFileName:_testImageFileName];
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:imageFilePath];
    if(existed){
        [[NSFileManager defaultManager] removeItemAtPath:imageFilePath error:nil];
    }
}

- (void)testSaveAndGetImageFile {
    UIImage * image = nil;
    
    CGFloat width = 50.0f;
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    [_testImageFileName drawInRect:CGRectMake(0, 0, width, width) withAttributes:nil];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[FileManager sharedInstance] saveImage:image withFileName:_testImageFileName];
    
    UIImage * imageFromFile = [[FileManager sharedInstance] getImageWithFileName:_testImageFileName];
    
    XCTAssertTrue([UIImagePNGRepresentation(image) isEqual:UIImagePNGRepresentation(imageFromFile)],"The two images are not same");
}

@end
