//
//  BNSTitleCell.m
//  项目界面
//
//  Created by jsix lei on 15/7/15.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "BNSTitleCell.h"
#import "UIImageView+WebCache.h"

@interface BNSTitleCell ()

@property (retain, nonatomic) UIImageView *profileImageView;
@property (retain, nonatomic) UILabel *titleLabel;
@end

@implementation BNSTitleCell

#pragma mark - BNSTitleCell Lifecycle

- (void)dealloc {
	
	[_titleLabel release];
	[_profileImageView release];
	
	[super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
			  reuseIdentifier:(NSString *)identifier {
	self = [super initWithStyle:style reuseIdentifier:identifier];
	if (self) {
		[self buildLayout];
	}
	return self;
}


#pragma mark - Notification

- (void)fontChanged:(NSNotification *)notification {
	NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
	UIFont *currentFont = [UIFont fontWithName:fontDic[@"fontName"] size:[fontDic[@"fontSize"] integerValue]];
	
	_titleLabel.font = currentFont;
}


#pragma mark - setter

- (void)setModel:(NewsModel *)model {
	_titleLabel.text = model.title;

	NSURL *imageURL = [NSURL URLWithString:model.imgsrc];
	[_profileImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"absent"]];
}

#pragma mark - Layout 

- (void)buildLayout {
	[self.contentView addSubview:self.profileImageView];
	[self.contentView addSubview:self.titleLabel];
	
	UIView *view = self.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _profileImageView,
														 _titleLabel);
	NSDictionary *metrics = @{@"imageViewHeight" : @200};
	
	//图片的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_profileImageView]|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//标题的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//垂直布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_profileImageView(imageViewHeight)]-[_titleLabel]-|"
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
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.numberOfLines = 0;
		_titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _titleLabel;
}

@end
