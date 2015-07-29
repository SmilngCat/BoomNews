//
//  LunBoScrollContentView.m
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSScrollContentView.h"

@interface BNSScrollContentView ()

@end

@implementation BNSScrollContentView

#pragma mark - LunBoScrollContentView Lifecycle

- (void)dealloc {
	
	[_leftImageView release];
	[_middleImageView release];
	[_rightImageView release];
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
	[self addSubview:self.leftImageView];
	[self addSubview:self.middleImageView];
	[self addSubview:self.rightImageView];
	
//	_leftImageView.userInteractionEnabled = YES;
//	_middleImageView.userInteractionEnabled = YES;
//	_rightImageView.userInteractionEnabled = YES;
//	
//	_leftImageView.backgroundColor = [UIColor colorWithRed:0.239 green:1.000 blue:0.378 alpha:1.000];
//	_middleImageView.backgroundColor = [UIColor colorWithRed:0.209 green:0.423 blue:1.000 alpha:1.000];
//	_rightImageView.backgroundColor = [UIColor colorWithRed:1.000 green:0.292 blue:0.922 alpha:1.000];
	UIView *view = self;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _leftImageView,
														 _middleImageView,
														 _rightImageView);
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftImageView(_rightImageView)][_middleImageView(_rightImageView)][_rightImageView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftImageView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_middleImageView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rightImageView]|"
																 options:0
																 metrics:0
																   views:views]];
	
}


#pragma mark - Lazy loading

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


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	NSLog(@"LunBoScrollContentView");
//}

@end
