//
//  MainViewController.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/7/1.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "MainViewController.h"
#import "../../Utils/UIUtils.h"
#import "../../ViewModels/PhotoViewModel.h"
#import "../../ViewModels/ViewModelManager.h"
#import "../PhotoListScreen/PhotoListViewController.h"

@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat btnWidth = 200;
    CGFloat btnHeight = 50;
    CGFloat btnVGap = btnHeight;
    
    CGFloat screenWidth = [UIUtils getMainScreenWidth];
    CGFloat screenHeight = [UIUtils getMainScreenHeight];
    
    CGFloat navBarHeight = [UIUtils getNavigationBarHeight];
    
    UIButton *takePhotoBtn = [[UIButton alloc]init];
    takePhotoBtn.frame = CGRectMake((screenWidth-btnWidth)/2, (screenHeight-btnHeight*2-btnVGap)/2-navBarHeight, btnWidth, btnHeight);
    takePhotoBtn.backgroundColor = UIColor.blueColor;
    takePhotoBtn.layer.cornerRadius = 4.0f;
    takePhotoBtn.layer.borderColor = [UIColor blueColor].CGColor;
    takePhotoBtn.layer.borderWidth = 1.0f;
    [takePhotoBtn setTitle:NSLocalizedString(@"Take a Photo", nil) forState:UIControlStateNormal];
    [takePhotoBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoBtn];
    
    UIButton *viewPhotosBtn = [[UIButton alloc]init];
    viewPhotosBtn.frame = CGRectMake(takePhotoBtn.frame.origin.x, takePhotoBtn.frame.origin.y+takePhotoBtn.frame.size.height+btnVGap, btnWidth, btnHeight);
    viewPhotosBtn.backgroundColor = takePhotoBtn.backgroundColor;
    viewPhotosBtn.layer.cornerRadius = takePhotoBtn.layer.cornerRadius;
    viewPhotosBtn.layer.borderColor = takePhotoBtn.layer.borderColor;
    viewPhotosBtn.layer.borderWidth = takePhotoBtn.layer.borderWidth;
    [viewPhotosBtn setTitle:NSLocalizedString(@"View Photos", nil) forState:UIControlStateNormal];
    [viewPhotosBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [viewPhotosBtn addTarget:self action:@selector(viewPhotosBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewPhotosBtn];
    
}

- (void)takePhotoBtnClicked {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)viewPhotosBtnClicked {
    PhotoListViewController *photoListViewController = [[PhotoListViewController alloc]init];
    photoListViewController.title = NSLocalizedString(@"Photo List", nil);
    [self.navigationController pushViewController:photoListViewController animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(image.imageOrientation != UIImageOrientationUp){
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    PhotoViewModel *photoViewModel = [[PhotoViewModel alloc]init];
    photoViewModel.image = image;
    
    [self showPhotoNameEdittingAlertView:photoViewModel];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showPhotoNameEdittingAlertView:(PhotoViewModel *)photoViewModel{
    
    NSString *alertMessage = NSLocalizedString(@"Please input the name of the photo", nil);
    NSString *cancelStr = NSLocalizedString(@"Cancel", nil);
    NSString *confirmStr = NSLocalizedString(@"Confirm", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField){}];
    
    ViewModelManager *vmManager = [ViewModelManager sharedInstance];
    
    [alertController addAction:[UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        photoViewModel.createdTimestamp = [NSDate date].timeIntervalSince1970;
        [vmManager savePhoto:photoViewModel];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *nameTextField = alertController.textFields.firstObject;
        
        photoViewModel.name = nameTextField.text;
        photoViewModel.createdTimestamp = [NSDate date].timeIntervalSince1970;
        
        [vmManager savePhoto:photoViewModel];
        
    }]];
    
    [self presentViewController:alertController animated:true completion:nil];
}

@end
