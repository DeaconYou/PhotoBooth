//
//  AsyncImageView.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "AsyncImageView.h"
#import "../Threading/AsyncOperationManager.h"
#import "../ViewModels/ViewModelManager.h"

@interface AsyncImageView ()

@property (strong, nonatomic) UIActivityIndicatorView * activityIndicator;

@end

@implementation AsyncImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeActivityIndicator];
    }
    return self;
}

- (void)setPhotoViewModel:(PhotoViewModel *)photoViewModel{
    if(!_photoViewModel && photoViewModel){
        _photoViewModel = photoViewModel;
        if(photoViewModel.image){
            self.image = photoViewModel.image;
        }else{
            NSString *fileName = [NSString stringWithFormat:@"%f", photoViewModel.createdTimestamp];
            [self startActivityIndicator];
            [[AsyncOperationManager sharedInstance] addOperationWithBlock:^{
                photoViewModel.image = [[ViewModelManager sharedInstance] getPhotoImageWithFileName:fileName];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.photoViewModel.image){
                        self.image = self.photoViewModel.image;
                    }
                    [self stopActivityIndicator];
                });
            } andKey:fileName];
        }
        
    }else if(_photoViewModel && _photoViewModel != photoViewModel){
        NSString *fileName = [NSString stringWithFormat:@"%f", _photoViewModel.createdTimestamp];
        [[AsyncOperationManager sharedInstance] cancelOperationIfNeededWithKey:fileName];
        self.image = nil;
        _photoViewModel = photoViewModel;
        if(photoViewModel.image){
            self.image = photoViewModel.image;
        }else{
            fileName = [NSString stringWithFormat:@"%f", photoViewModel.createdTimestamp];
            [self startActivityIndicator];
            [[AsyncOperationManager sharedInstance] addOperationWithBlock:^{
                photoViewModel.image = [[ViewModelManager sharedInstance] getPhotoImageWithFileName:fileName];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.photoViewModel.image){
                        self.image = self.photoViewModel.image;
                    }
                    [self stopActivityIndicator];
                });
            } andKey:fileName];
        }
    }
}

- (void)initializeActivityIndicator{
    if(!_activityIndicator){
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [self addSubview:_activityIndicator];
        CGFloat indicatorWidth = 50;
        _activityIndicator.frame= CGRectMake((self.frame.size.width-indicatorWidth)/2.0f, (self.frame.size.height-indicatorWidth)/2.0f, indicatorWidth, indicatorWidth);
        _activityIndicator.hidesWhenStopped = YES;
    }
}

- (void)startActivityIndicator{
    if(_activityIndicator){
        [_activityIndicator startAnimating];
    }
}

- (void)stopActivityIndicator{
    if(_activityIndicator){
        [_activityIndicator stopAnimating];
    }
}

@end
