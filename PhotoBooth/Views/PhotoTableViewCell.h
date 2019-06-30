//
//  PhotoTableViewCell.h
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ViewModels/PhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTableViewCell : UITableViewCell

@property (strong, nonatomic) PhotoViewModel *photoViewModel;

@end

NS_ASSUME_NONNULL_END
