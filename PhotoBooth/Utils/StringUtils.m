//
//  StringUtils.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (BOOL)isBlank:(NSString *)str{
    return str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || ( [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 );
}

@end
