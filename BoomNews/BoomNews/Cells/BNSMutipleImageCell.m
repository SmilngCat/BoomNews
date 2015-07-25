//
//  NewsListMutipleImageCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMutipleImageCell.h"
#import "UIImageView+WebCache.h"


//layout
#define kImageViewWidth 100
#define kImageViewHeight 100

@interface BNSMutipleImageCell ()

@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UIImageView *leftImageView;
@property (retain, nonatomic) UIImageView *middleImageView;
@property (retain, nonatomic) UIImageView *rightImageView;
@end

@implementation BNSMutipleImageCell

#pragma mark - BNSMutipleImageCell Lifecycle

- (void)dealloc {
	
	[_titleLabel release];
	[_leftImageView release];
	[_middleImageView release];
	[_rightImageView release];
	
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
	NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForMutableKey:@"TintFont"];
	UIFont *currentFont = [UIFont fontWithName:fontDic[@"fontName"] size:[fontDic[@"fontSize"] integerValue]];
	
	_titleLabel.font = currentFont;
}


#pragma mark - Setter

- (void)setModel:(NewsModel *)model {
	
	_titleLabel.text = model.title;
	
	NSURL *imageURL = [NSURL URLWithString:model.imgsrc];
	[_leftImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"absent"]];

	NSURL *middleImageURL = [NSURL URLWithString:[model.imgextraArray[0] imgsrc]];
	NSURL *rightImageURL = [NSURL URLWithString:[model.imgextraArray[1] imgsrc]];
	[_middleImageView sd_setImageWithURL:middleImageURL placeholderImage:[UIImage imageNamed:@"absent"]];
	[_rightImageView sd_setImageWithURL:rightImageURL placeholderImage:[UIImage imageNamed:@"absent"]];

}

#pragma mark - Layout

- (void)buildLayout {
	[self.contentView addSubview:self.titleLabel];
	[self.contentView addSubview:self.leftImageView];
	[self.contentView addSubview:self.middleImageView];
	[self.contentView addSubview:self.rightImageView];
	
	UIView *view = self.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _titleLabel,
														 _leftImageView,
														 _middleImageView,
														 _rightImageView);
	NSDictionary *metrics = @{@"width" : @(kImageViewWidth),
							  @"height" : @(kImageViewHeight)};
	
	//标题的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	
	//图片的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_leftImageView]-[_middleImageView(_leftImageView)]-[_rightImageView(_leftImageView)]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	
	//设置标题与左图片之间的高度
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-[_leftImageView(height)]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//中间图片的高度与左边图片的高度相同
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_middleImageView(_leftImageView)]"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//右边图片的高度与左边图片的高度相同
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_rightImageView(_leftImageView)]"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//中间图片的高度与左边图片的顶部对齐
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleImageView
																 attribute:NSLayoutAttributeTop
																 relatedBy:NSLayoutRelationEqual
																	toItem:_leftImageView
																 attribute:NSLayoutAttributeTop
																multiplier:1.f constant:0]];
	//右边图片的高度与左边图片的顶部对齐
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
																 attribute:NSLayoutAttributeTop
																 relatedBy:NSLayoutRelationEqual
																	toItem:_leftImageView
																 attribute:NSLayoutAttributeTop
																multiplier:1.f constant:0]];
}


#pragma mark - Lazy loading

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _titleLabel;
}

- (UIImageView *)leftImageView {
	if (!_leftImageView) {
		_leftImageView = [[UIImageView alloc] init];
		_leftImageView.contentMode = UIViewContentModeScaleToFill;
		_leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _leftImageView;
}

- (UIImageView *)middleImageView {
	if (!_middleImageView) {
		_middleImageView = [[UIImageView alloc] init];
		_middleImageView.contentMode = UIViewContentModeScaleToFill;
		_middleImageView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _middleImageView;
}

- (UIImageView *)rightImageView {
	if (!_rightImageView) {
		_rightImageView = [[UIImageView alloc] init];
		_rightImageView.contentMode = UIViewContentModeScaleToFill;
		_rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _rightImageView;
}

@end
