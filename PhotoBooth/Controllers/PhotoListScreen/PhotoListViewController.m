//
//  PhotoListViewController.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "PhotoListViewController.h"
#import "../../ViewModels/ViewModelManager.h"
#import "../../Views/PhotoTableViewCell.h"
#import "../PhotoScreen/PhotoViewController.h"
#import "../../Utils/UIUtils.h"
#import "../../Utils/StringUtils.h"

@interface PhotoListViewController ()

@property (strong, nonatomic) NSArray *photoViewModels;

@end

@implementation PhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photoViewModels = [[ViewModelManager sharedInstance] getAllPhotos];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getMainScreenWidth], [UIUtils getMainScreenHeight]) style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_photoViewModels count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PhotoCellReuseIdentifier = @"PhotoCellReuseIdentifier";
    PhotoTableViewCell *photoCell = (PhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PhotoCellReuseIdentifier];
    if (photoCell == nil) {
        photoCell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:PhotoCellReuseIdentifier];
    }
    
    PhotoViewModel *photoViewModel = (PhotoViewModel *)[_photoViewModels objectAtIndex:indexPath.row];
    
    [photoCell setPhotoViewModel:photoViewModel];
    
    return photoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoViewModel *photoViewModel = (PhotoViewModel *)[_photoViewModels objectAtIndex:indexPath.row];
    PhotoViewController *photoViewController = [[PhotoViewController alloc]init];
    if(![StringUtils isBlank:photoViewModel.name]){
        photoViewController.title = photoViewModel.name;
    }
    photoViewController.photoViewModel = photoViewModel;
    [self.navigationController pushViewController:photoViewController animated:YES];
}

@end
