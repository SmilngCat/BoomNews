//
//  LunBoScrollContentView.m
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "OrderScrollContentView.h"



@interface OrderScrollContentView ()

@end

@implementation OrderScrollContentView

#pragma mark - LunBoScrollContentView Lifecycle

- (void)dealloc {
	
	[_leftView release];
	[_middleView release];
	[_rightView release];
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
	[self addSubview:self.leftView];
	[self addSubview:self.middleView];
	[self addSubview:self.rightView];
	
	UIView *view = self;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _leftView,
														 _middleView,
														 _rightView);
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftView(_rightView)][_middleView(_rightView)][_rightView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_middleView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rightView]|"
																 options:0
																 metrics:0
																   views:views]];
}

#pragma mark - Lazy loading

- (ContentView *)leftView {
	if (!_leftView) {
		_leftView = [[ContentView alloc] init];
		_leftView.contentMode = UIViewContentModeScaleToFill;
		_leftView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _leftView;
}

- (ContentView *)middleView {
	if (!_middleView) {
		_middleView = [[ContentView alloc] init];
		_middleView.contentMode = UIViewContentModeScaleToFill;
		_middleView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _middleView;
}

- (ContentView *)rightView {
	if (!_rightView) {
		_rightView = [[ContentView alloc] init];
		_rightView.contentMode = UIViewContentModeScaleToFill;
		_rightView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _rightView;
}


@end
