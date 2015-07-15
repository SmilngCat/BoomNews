//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "NewsTypeScrollBar.h"
#import "NewsTypeScrollBarContentView.h"

@interface NewsTypeScrollBar ()
@end

@implementation NewsTypeScrollBar

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

- (NewsTypeScrollBarContentView *)contentView {
	if (!_contentView) {
		_contentView = [[NewsTypeScrollBarContentView alloc] init];
		_contentView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _contentView;
}



@end
