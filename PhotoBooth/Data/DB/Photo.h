//
//  Photo.h
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) double createdTimestamp;

@end

NS_ASSUME_NONNULL_END
