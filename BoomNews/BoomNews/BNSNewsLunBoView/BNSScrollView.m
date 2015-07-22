//
//  LunBoScrollView.m
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSScrollView.h"
#import "BNSScrollContentView.h"


@implementation BNSScrollView

#pragma mark - LunBoScrollView Lifecycle

- (void)dealloc {
	[_contentView release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_contentView = [[BNSScrollContentView alloc] init];
		_contentView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_contentView];
		
		[self buildLayout];
		
		//_contentView.backgroundColor = [UIColor redColor];
	}
	return self;
}

#pragma mark - Layout

- (void)buildLayout {
	UIView *view = self;
	NSDictionary *views = NSDictionaryOfVariableBindings(view, _contentView);
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
																 options:0
																 metrics:0
																   views:views]];
}



@end
