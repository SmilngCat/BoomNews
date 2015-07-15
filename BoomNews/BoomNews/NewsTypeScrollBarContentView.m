//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "NewsTypeScrollBarContentView.h"
#import "NewsTypeScrollBarButton.h"

@interface NewsTypeScrollBarContentView ()

@property (retain, nonatomic) UIButton *politicsButton;
@property (retain, nonatomic) UIButton *entertainmentButton;
@property (retain, nonatomic) UIButton *sportsButton;
@property (retain, nonatomic) UIButton *gamesButton;
@end

@implementation NewsTypeScrollBarContentView

#pragma mark - NewsTypeScrollBar Lifecycle

- (void)dealloc {
	[_politicsButton release];
	[_entertainmentButton release];
	[_sportsButton release];
	[_gamesButton release];
	
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self buildLayout];
	}
	return self;
}


#pragma mark - Layout

- (void)buildLayout {
	
	self.politicsButton = [NewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	self.entertainmentButton = [NewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	self.sportsButton = [NewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	self.gamesButton = [NewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	
	[_politicsButton setTitle:@"政务" forState:UIControlStateNormal];
	[_entertainmentButton setTitle:@"娱乐" forState:UIControlStateNormal];
	[_sportsButton setTitle:@"体育" forState:UIControlStateNormal];
	[_gamesButton setTitle:@"游戏" forState:UIControlStateNormal];
	
	[self addSubview:_politicsButton];
	[self addSubview:_entertainmentButton];
	[self addSubview:_sportsButton];
	[self addSubview:_gamesButton];
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	UIView *view = self;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _politicsButton,
														 _entertainmentButton,
														 _sportsButton,
														 _gamesButton);
	NSDictionary *metrics = @{@"spacing" : @20,
							  @"margin" : @10};
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_politicsButton]-spacing-[_entertainmentButton]-spacing-[_sportsButton]-spacing-[_gamesButton]-margin-|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_politicsButton]-margin-|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_entertainmentButton]-margin-|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_sportsButton]-margin-|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_gamesButton]-margin-|"
																 options:0
																 metrics:metrics
																   views:views]];
}




@end
