//
//  DatabaseManagerTests.m
//  PhotoBoothTests
//
//  Created by Deacon You on 2019/7/1.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../PhotoBooth/Data/DB/Photo.h"
#import "../PhotoBooth/Data/DB/DatabaseManager.h"

@interface DatabaseManagerTests : XCTestCase

@property (strong, nonatomic) Photo *photo;

@end

@implementation DatabaseManagerTests

- (void)setUp {
    _photo = [[Photo alloc]init];
    _photo.name = @"TestPhotoName";
    _photo.createdTimestamp = [NSDate date].timeIntervalSince1970;
}

- (void)tearDown {
    [[DatabaseManager sharedInstance] deletePhoto:_photo];
}

- (void)testInsertPhoto {
    [[DatabaseManager sharedInstance] insertPhoto:_photo];
    
    NSArray * photos = [[DatabaseManager sharedInstance] selectAllPhotos];
    
    BOOL photoExisted = NO;
    
    for(Photo * pto in photos){
        if([pto.name isEqualToString:_photo.name] && pto.createdTimestamp == _photo.createdTimestamp){
            photoExisted = YES;
            break;
        }
    }
    
    XCTAssertTrue(photoExisted,"The photo is not inserted correctly");
}

@end
