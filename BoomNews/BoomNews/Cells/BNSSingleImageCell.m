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
	NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForMutableKey:@"TintFont"];
	UIFont *currentFont = [UIFont fontWithName:fontDic[@"fontName"] size:[fontDic[@"fontSize"] integerValue]];
	
	_titleLabel.font = currentFont;
	_briefLabel.font = currentFont;
}


#pragma mark - setter

- (void)setModel:(NewsModel *)model {
	
	if (_model != model) {
		[_model release];
		_model = [model retain];
		
		_titleLabel.text = model.title;
		_briefLabel.text = model.digest;
		
		NSURL *imageURL = [NSURL URLWithString:model.imgsrc];
		[_profileImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"absent"]];
	}
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
	NSDictionary *metrics = @{
							  @"width" : @(kImageViewWidth),
							  @"height" : @(kImageViewHeight)};
	//增加图片与标题之间的横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_profileImageView(width)]-[_titleLabel]-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	
	//标题与副标题之间的垂直布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-[_briefLabel]-|"
																			 options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing
																			 metrics:metrics
																			   views:views]];
	//图片与标题和副标题之间上下对齐
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_profileImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
	
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_profileImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_briefLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:0]];
	
	//_profileImageView的高度以显示设置的约束为主
	[_profileImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
	[_profileImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
	
	//_titleLabel和_briefLabel的高度以intrinsic Contentsize的约束为主
	[_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
	
	[_briefLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_briefLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
	
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat width = [UIScreen mainScreen].bounds.size.width - 120 - 30;
	
	_titleLabel.preferredMaxLayoutWidth = width;
	_briefLabel.preferredMaxLayoutWidth = width;

	[super layoutSubviews];
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
		_titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		
		CGFloat width = [UIScreen mainScreen].bounds.size.width - 120 - 30;
		_titleLabel.preferredMaxLayoutWidth = width;
	}
	return _titleLabel;
}

- (UILabel *)briefLabel {
	if (!_briefLabel) {
		_briefLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_briefLabel.numberOfLines = 0;
		_briefLabel.lineBreakMode = NSLineBreakByWordWrapping;
		_briefLabel.translatesAutoresizingMaskIntoConstraints = NO;
		
		CGFloat width = [UIScreen mainScreen].bounds.size.width - 120 - 30;
		_briefLabel.preferredMaxLayoutWidth = width;
	}
	return _briefLabel;
}

@end
