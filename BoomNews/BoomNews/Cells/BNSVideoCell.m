//
//  BNSVideoTableViewCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoCell.h"
#import "BNSVideoPlayerView.h"
#import "UIImageView+WebCache.h"

@interface BNSVideoCell ()

@property (retain, nonatomic) UIImageView *coverImageView;
@property (retain, nonatomic) BNSVideoPlayerView *videoPlayer;
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UIImageView *timeImageView;
@property (retain, nonatomic) UILabel *timeLabel;
@property (retain, nonatomic) UIImageView *countImageView;
@property (retain, nonatomic) UILabel *countLabel;
@end

@implementation BNSVideoCell

#pragma mark - BNSVideoTableViewCell Lifecycle

- (void)dealloc {
	
	[_coverImageView release];
	[_videoPlayer release];
	[_titleLabel release];
	[_timeLabel release];
	[_countLabel release];
	[_timeImageView release];
	[_countImageView release];
	

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
	_timeLabel.font = currentFont;
	_countLabel.font = currentFont;
}


#pragma mark - setter

- (void)setModel:(VideoModel *)model {
	
	if (_model != model) {
		[_model release];
		_model = [model retain];
		
		_titleLabel.text = nil;
		_timeLabel.text = nil;
		_countLabel.text = nil;
		[self reset];
		
		[_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"absent"]];
		_titleLabel.text = model.title;
		_timeLabel.text = [NSString stringWithFormat:@"%@", model.length];
		_countLabel.text = [NSString stringWithFormat:@"%@", model.playCount];
		_videoPlayer.urlString = model.m3u8_url;
	}
}

#pragma mark - layout

- (void)buildLayout {
	[self.contentView addSubview:self.videoPlayer];
	[self.contentView addSubview:self.titleLabel];
	[self.contentView addSubview:self.timeLabel];
	[self.contentView addSubview:self.countLabel];
	[self.contentView addSubview:self.timeImageView];
	[self.contentView addSubview:self.countImageView];
	[self.contentView addSubview:self.coverImageView];
	
	UIView *view = self.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _coverImageView,
														 _videoPlayer,
														 _titleLabel,
														 _timeImageView,
														 _timeLabel,
														 _countImageView,
														 _countLabel);
	
	NSDictionary *metrics = @{@"space" : @10, @"playerHeight" : @ 200, @"ImageViewHeight" : @16};
	
	//videoPlayer横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-space-[_videoPlayer]-space-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//titleLabel横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-space-[_titleLabel]-space-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	//时间横向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-space-[_timeImageView(ImageViewHeight)]-space-[_timeLabel]-50-[_countImageView(ImageViewHeight)]-space-[_countLabel]"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	
	//纵向布局
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-space-[_videoPlayer(playerHeight)]-space-[_titleLabel]-space-[_timeImageView(ImageViewHeight)]-space-|"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_countImageView(ImageViewHeight)]"
																			 options:0
																			 metrics:metrics
																			   views:views]];
	
	//最下面的四个视图的顶点对齐
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_timeImageView attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
	
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_countImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_timeImageView attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
	
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_countLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_timeImageView attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
	
	//coverImageView
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_coverImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_videoPlayer attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
	
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_coverImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_videoPlayer attribute:NSLayoutAttributeLeft multiplier:1.f constant:0]];
	
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_coverImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_videoPlayer attribute:NSLayoutAttributeWidth multiplier:1.f constant:0]];
	
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_coverImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_videoPlayer attribute:NSLayoutAttributeHeight multiplier:1.f constant:0]];

}


#pragma mark - Actions

- (void)play:(UITapGestureRecognizer *)sender {

	[self.contentView sendSubviewToBack:self.coverImageView];
	self.coverImageView.opaque = 0.0f;
	[self.videoPlayer play];
}

- (void)reset {
	[self.contentView bringSubviewToFront:self.coverImageView];
	self.coverImageView.opaque = 1.f;
	[self.videoPlayer stop];
}

#pragma mark - Lazy loading

- (UIImageView *)coverImageView {
	if (!_coverImageView) {
		_coverImageView = [[UIImageView alloc] init];
		_coverImageView.contentMode = UIViewContentModeScaleToFill;
		_coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
		_coverImageView.userInteractionEnabled = YES;
		
		UITapGestureRecognizer *gestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play:)] autorelease];
		[_coverImageView addGestureRecognizer:gestureRecognizer];
	}
	return _coverImageView;
}

- (BNSVideoPlayerView *)videoPlayer {
	if (!_videoPlayer) {
		_videoPlayer = [[BNSVideoPlayerView alloc] init];
		_videoPlayer.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _videoPlayer;
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

- (UIImageView *)timeImageView {
	if (!_timeImageView) {
		_timeImageView = [[UIImageView alloc] init];
		_timeImageView.contentMode = UIViewContentModeScaleToFill;
		_timeImageView.translatesAutoresizingMaskIntoConstraints = NO;
		_timeImageView.image = [UIImage imageNamed:@"time"];
	}
	return _timeImageView;
}

- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _timeLabel;
}

- (UIImageView *)countImageView {
	if (!_countImageView) {
		_countImageView = [[UIImageView alloc] init];
		_countImageView.contentMode = UIViewContentModeScaleToFill;
		_countImageView.translatesAutoresizingMaskIntoConstraints = NO;
		_countImageView.image = [UIImage imageNamed:@"count"];
	}
	return _countImageView;
}

- (UILabel *)countLabel {
	if (!_countLabel) {
		_countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_countLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _countLabel;
}

@end
