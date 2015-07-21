//
//  BNSVideoTableViewCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoCell.h"
#import "BNSVideoPlayerView.h"

@interface BNSVideoCell ()

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
	
	[_videoPlayer release];
	[_titleLabel release];
	[_timeLabel release];
	[_countLabel release];
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

#pragma mark - setter

- (void)setModel:(VideoModel *)model {
	_videoPlayer.urlString = model.m3u8_url;
	_titleLabel.text = model.title;
	_timeLabel.text = [NSString stringWithFormat:@"%@", model.length];
	_countLabel.text = [NSString stringWithFormat:@"%@", model.playCount];
}

#pragma mark - layout

- (void)buildLayout {
	[self.contentView addSubview:self.videoPlayer];
	[self.contentView addSubview:self.titleLabel];
	[self.contentView addSubview:self.timeLabel];
	[self.contentView addSubview:self.countLabel];
	[self.contentView addSubview:self.timeImageView];
	[self.contentView addSubview:self.countImageView];
	
	UIView *view = self.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view, _videoPlayer, _titleLabel, _timeImageView, _timeLabel, _countImageView, _countLabel);
	
	NSDictionary *metrics = @{@"space" : @10, @"playerHeight" : @ 150, @"ImageViewHeight" : @20};
	
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

}


#pragma mark - Lazy loading

- (BNSVideoPlayerView *)videoPlayer {
	if (!_videoPlayer) {
		_videoPlayer = [[BNSVideoPlayerView alloc] init];
		_videoPlayer.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _videoPlayer;
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

- (UIImageView *)timeImageView {
	if (!_timeImageView) {
		_timeImageView = [[UIImageView alloc] init];
		_timeImageView.contentMode = UIViewContentModeScaleToFill;
		_timeImageView.translatesAutoresizingMaskIntoConstraints = NO;
#warning to add pic
	}
	return _timeImageView;
}

- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		_timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _timeLabel;
}

- (UIImageView *)countImageView {
	if (!_countImageView) {
		_countImageView = [[UIImageView alloc] init];
		_countImageView.contentMode = UIViewContentModeScaleToFill;
		_countImageView.translatesAutoresizingMaskIntoConstraints = NO;
#warning to add pic
	}
	return _countImageView;
}

- (UILabel *)countLabel {
	if (!_countLabel) {
		_countLabel = [[UILabel alloc] init];
		_countLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _countLabel;
}

@end
