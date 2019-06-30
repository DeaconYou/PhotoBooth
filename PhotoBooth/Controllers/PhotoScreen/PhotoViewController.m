//
//  PhotoViewController.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "PhotoViewController.h"
#import "../../ViewModels/ViewModelManager.h"
#import "../../Utils/UIUtils.h"
#import "../../Utils/StringUtils.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    if(_photoViewModel){
        UIImageView *photoImageView = [[UIImageView alloc] init];
        photoImageView.frame = CGRectMake(0, 22, [UIUtils getMainScreenWidth], [UIUtils getMainScreenHeight]);
        photoImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if(_photoViewModel.image){
            photoImageView.image = _photoViewModel.image;
        }else{
            photoImageView.image = [[ViewModelManager sharedInstance]getPhotoImageWithFileName:[NSString stringWithFormat:@"%f", _photoViewModel.createdTimestamp]];
        }
        
        [self.view addSubview:photoImageView];
    }
    
}

@end
