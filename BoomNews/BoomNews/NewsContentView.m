//
//  NewsContentView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "NewsContentView.h"
#import "NewsTypeScrollBar.h"

@interface NewsContentView ()

@property (retain, nonatomic) NewsTypeScrollBar *scrollBar;

@end

@implementation NewsContentView

#pragma mark - NewsContentView Lifecycle

- (void)dealloc {
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
	
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
}


@end
