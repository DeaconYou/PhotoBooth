//
//  UIUtils.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "UIUtils.h"
#import "AppDelegate.h"

@implementation UIUtils

+ (CGSize)getMainScreenSize{
    return UIScreen.mainScreen.bounds.size;
}

+ (CGFloat)getMainScreenWidth{
    return [UIUtils getMainScreenSize].width;
}

+ (CGFloat)getMainScreenHeight{
    return [UIUtils getMainScreenSize].height;
}

+ (CGRect)getNavigationBarFrame{
    return ((AppDelegate *)([UIApplication sharedApplication].delegate)).navController.navigationBar.frame;
}

+ (CGFloat)getNavigationBarHeight{
    return [UIUtils getNavigationBarFrame].size.height;
}

@end
