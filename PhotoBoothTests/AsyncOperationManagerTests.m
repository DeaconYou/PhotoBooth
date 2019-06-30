//
//  AsyncOperationManagerTests.m
//  PhotoBoothTests
//
//  Created by Deacon You on 2019/7/1.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../PhotoBooth/Threading/AsyncOperationManager.h"

@interface AsyncOperationManagerTests : XCTestCase

@end

@implementation AsyncOperationManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testOperationQueue {
    [[AsyncOperationManager sharedInstance] addOperationWithBlock:^{
        sleep(1);
    } andKey:@"testOperation1"];
    
    [[AsyncOperationManager sharedInstance] addOperationWithBlock:^{
        sleep(1);
    } andKey:@"testOperation2"];
    
    [[AsyncOperationManager sharedInstance] addOperationWithBlock:^{
        sleep(1);
    } andKey:@"testOperation3"];
    
    [self assertTheCountOfOpeationQueueAndDict:3];
    
    sleep(8);
    
    [self assertTheCountOfOpeationQueueAndDict:0];
}

- (void)assertTheCountOfOpeationQueueAndDict:(int)correctCount{
    int countOfOperationQueue = [[AsyncOperationManager sharedInstance]getCountOfOperationsInOperationQueue];
    XCTAssertTrue((countOfOperationQueue == correctCount), @"The count of operations in operation queue should be %d but %d", correctCount, countOfOperationQueue);
    
    int countOfDict = [[AsyncOperationManager sharedInstance]getCountOfOperationDict];
    XCTAssertTrue((countOfDict == correctCount), @"The count of operation dict should be %d but %d", correctCount, countOfDict);
}

@end
