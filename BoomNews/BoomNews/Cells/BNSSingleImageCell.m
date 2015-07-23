//
//  NewsListCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSSingleImageCell.h"
#import "UIImageView+WebCache.h"


//layout
#define kImageViewWidth 120
#define kImageViewHeight 100

@interface BNSSingleImageCell ()

@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *briefLabel;
@property (retain, nonatomic) UIImageView *profileImageView;
@end

@implementation BNSSingleImageCell

#pragma mark - BNSSingleImageCell Lifecycle

- (void)dealloc {
	
	[_profileImageView release];
	[_titleLabel release];
	[_briefLabel release];
	
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
	_briefLabel.font = currentFont;
}


#pragma mark - setter

- (void)setModel:(NewsModel *)model {
	_titleLabel.text = model.title;
	_briefLabel.text = model.digest;

	NSURL *imageURL = [NSURL URLWithString:model.imgsrc];
	[_profileImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"absent"]];
}


#pragma mark - Layout

- (void)buildLayout {
	[self.contentView addSubview:self.profileImageView];
	[self.contentView addSubview:self.titleLabel];
	[self.contentView addSubview:self.briefLabel];
	
	UIView *view = self.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _profileImageView,
														 _titleLabel,
														 _briefLabel);
	NSDictionary *metrics = @{@"space" : @10,
							  @"width" : @(kImageViewWidth),
							  @"height" : @(kImageViewHeight)};
	//增加图片与标题之间的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_profileImageView(width)]-space-[_titleLabel]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//标题与副标题左对齐
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_briefLabel
																 attribute:NSLayoutAttributeLeft
																 relatedBy:NSLayoutRelationEqual
																	toItem:_titleLabel
																 attribute:NSLayoutAttributeLeft
																multiplier:1.f constant:0]];
	//副标题右边链接父视图
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_briefLabel]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//图片的高度可增加
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-space-[_profileImageView(height)]-space-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//标题与副标题之间的垂直布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-space-[_titleLabel]-20@749-[_briefLabel]-space-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
}


#pragma mark - Lazy loading

- (UIImageView *)profileImageView {
	if (!_profileImageView) {
		_profileImageView = [[UIImageView alloc] init];
		_profileImageView.contentMode = UIViewContentModeScaleToFill;
		_profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _profileImageView;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.numberOfLines = 0;
		_briefLabel.lineBreakMode = NSLineBreakByWordWrapping;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		
	}
	return _titleLabel;
}

- (UILabel *)briefLabel {
	if (!_briefLabel) {
		_briefLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_briefLabel.numberOfLines = 0;
		_briefLabel.lineBreakMode = NSLineBreakByWordWrapping;
		_briefLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _briefLabel;
}

@end
