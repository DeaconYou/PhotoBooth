//
//  PhotoTableViewCell.m
//  PhotoBooth
//
//  Created by Deacon You on 2019/6/30.
//  Copyright © 2019 MuLight. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "AsyncImageView.h"
#import "../Utils/UIUtils.h"
#import "../Utils/StringUtils.h"

@interface PhotoTableViewCell ()

@property (strong, nonatomic) AsyncImageView *photoImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *createdTimeLabel;

@end

@implementation PhotoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _photoImageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 80)];
        _photoImageView.backgroundColor = UIColor.lightGrayColor;
        [self.contentView addSubview:_photoImageView];
        
        _nameLabel = [[UILabel alloc] init];
        CGFloat originX = _photoImageView.frame.origin.x+_photoImageView.frame.size.width+20;
        _nameLabel.frame = CGRectMake(originX, 8, self.contentView.frame.size.width-originX-20, 55);
        _nameLabel.textColor = UIColor.blackColor;
        _nameLabel.numberOfLines = 0;
        [self.contentView addSubview:_nameLabel];
        
        _createdTimeLabel = [[UILabel alloc] init];
        _createdTimeLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y+_nameLabel.frame.size.height+4, _nameLabel.frame.size.width, 18);
        _createdTimeLabel.textColor = UIColor.blackColor;
        [self.contentView addSubview:_createdTimeLabel];
    }
    
    return self;
}

- (void)setPhotoViewModel:(PhotoViewModel *)photoViewModel{
    _photoViewModel = photoViewModel;
    
    _photoImageView.photoViewModel = photoViewModel;
    
    _nameLabel.text = ([StringUtils isBlank:_photoViewModel.name] ? NSLocalizedString(@"Empty photo name", nil) : _photoViewModel.name);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_photoViewModel.createdTimestamp];
    _createdTimeLabel.text = [dateFormatter stringFromDate:date];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
