//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBar.h"
#import "BNSNewsTypeScrollBarContentView.h"

@interface BNSNewsTypeScrollBar ()
@end

@implementation BNSNewsTypeScrollBar

#pragma mark - NewsTypeScrollBar Lifecycle

- (void)dealloc {
	
	[_contentView release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.bounces = NO;
		self.pagingEnabled = YES;
		[self addSubview:self.contentView];
	}
	return self;
}

#pragma mark - Layout 

- (void)layoutSubviews {
	[super layoutSubviews];
	

}

#pragma mark - Lazy loading

- (BNSNewsTypeScrollBarContentView *)contentView {
	if (!_contentView) {
		_contentView = [[BNSNewsTypeScrollBarContentView alloc] init];
		_contentView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _contentView;
}



@end
