//
//  BNSSpecialImageCell.m
//  项目界面
//
//  Created by 邵垚 on 15/7/16.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "BNSSpecialImageCell.h"
#import "UIImageView+WebCache.h"

@interface BNSSpecialImageCell ()

@property (retain, nonatomic) UILabel *titleLabel;

@property (retain, nonatomic) UIImageView *profileImageView;

@property (retain, nonatomic) UILabel *digestLabel;
@end

@implementation BNSSpecialImageCell

#pragma mark - BNSSpecial Lifecycle

- (void)dealloc {
    
    [_titleLabel release];
    [_digestLabel release];
    [_profileImageView release];
    [super dealloc];
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {


    self = [super initWithStyle:style reuseIdentifier:identifier];
    if (self) {
        [self buildLayout];
    }
    return self;



}

#pragma mark - setter

- (void)setModel:(NewsModel *)model {
    _digestLabel.text = model.digest;
    _titleLabel.text = model.title;

    if (!model.imgsrc) {
        UIImage *absentImage = [UIImage imageNamed:@"Absent"];
        _profileImageView.image = absentImage;
    }else {
        NSURL *imageURL = [NSURL URLWithString:model.imgsrc];
        [_profileImageView sd_setImageWithURL:imageURL];
    }
}


#pragma mark - Layout

- (void)buildLayout {
    [self.contentView addSubview:self.profileImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.digestLabel];
	
	UIView *view = self.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 
														 _profileImageView,
														 _titleLabel,
														 _digestLabel);
	NSDictionary *metrics = @{
							  @"imageViewHeight" : @130};
	//图片的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_profileImageView]-|"
																			 options:0
																			 metrics:metrics
																			   views:views
									  ]];
	//标题的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
																			 options:0
																			 metrics:metrics views:views]];
	
	
	//详情的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_digestLabel]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//垂直布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-[_profileImageView(imageViewHeight)]-[_digestLabel]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
}


#pragma mark - LazyLoading

- (UIImageView *)profileImageView {
    if (!_profileImageView) {
        _profileImageView = [[UIImageView alloc] init];
        _profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _profileImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;


}

- (UILabel *)digestLabel {
    if (!_digestLabel) {
        _digestLabel = [[UILabel alloc] init];
        _digestLabel.numberOfLines = 0;
        _digestLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _digestLabel.font = [UIFont systemFontOfSize:13];
        _digestLabel.textColor = [UIColor grayColor];
        _digestLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _digestLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
