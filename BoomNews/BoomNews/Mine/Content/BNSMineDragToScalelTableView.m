//
//  BNSMineDragToScalelTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/27.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineDragToScalelTableView.h"

@interface BNSMineDragToScalelTableView () 

@end

@implementation BNSMineDragToScalelTableView

#pragma mark - BNSMineDragToScalelTableView Lifecycle

- (void)dealloc {
	
	[_scaleImageView release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	self = [super initWithFrame:frame style:style];
	if (self) {

		[self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SETTING"];
		
		//隐藏多余的cell
		UIView *footerView = [[[UIView alloc] init] autorelease];
		footerView.backgroundColor = [UIColor clearColor];
		self.tableFooterView = footerView;
		
		[self buildLayout];
	}
	return self;
}

#pragma mark - Layout

- (void)buildLayout {
	[self insertSubview:self.scaleImageView atIndex:0];
	
	CGFloat height = CGRectGetHeight(self.bounds) * 0.5f;
	
	NSDictionary *views = NSDictionaryOfVariableBindings(self, _scaleImageView);
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scaleImageView]|"
																 options:0
																 metrics:0
																   views:views]];
	
	self.constraint = [NSLayoutConstraint constraintWithItem:_scaleImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:-(height)];
	[self addConstraint:_constraint];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:_scaleImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0]];
}

#pragma mark - Lazy loading

- (UIImageView *)scaleImageView {
	if (!_scaleImageView) {
		_scaleImageView = [[[UIImageView alloc] init] autorelease];
		_scaleImageView.image = [UIImage imageNamed:@"avatarImage"];
		_scaleImageView.contentMode = UIViewContentModeScaleAspectFill;
		_scaleImageView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _scaleImageView;
}

@end
