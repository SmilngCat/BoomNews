//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBarContentView.h"

@interface BNSNewsTypeScrollBarContentView ()
@end

@implementation BNSNewsTypeScrollBarContentView

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
	
	self.politicsButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	self.entertainmentButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	self.sportsButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	self.gamesButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	
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
	//button之间的间距
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat gapWidth = (width - 4 * 50) / 5.f;
	
	NSDictionary *metrics = @{@"spacing" : @(gapWidth),
							  @"buttonWidth" : @50};
	//横向布局
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_entertainmentButton(buttonWidth)]-spacing-[_sportsButton(buttonWidth)]-spacing-[_gamesButton(buttonWidth)]-spacing-[_politicsButton(>=buttonWidth)]-spacing-|"
																 options:0
																 metrics:metrics
																   views:views]];
	//纵向布局
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_politicsButton(30)]|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_entertainmentButton(30)]|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_sportsButton(30)]|"
																 options:0
																 metrics:metrics
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_gamesButton(30)]|"
																 options:0
																 metrics:metrics
																   views:views]];
}




@end
