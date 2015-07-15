//
//  NewsTypeScrollBarButton.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBarButton.h"
#import "NewsTypeScrollBarButtonDelegate.h"

@implementation BNSNewsTypeScrollBarButton

+ (instancetype)buttonWithType:(UIButtonType)type {
	BNSNewsTypeScrollBarButton *button= [super buttonWithType:type];
	if (button) {
		button.translatesAutoresizingMaskIntoConstraints = NO;
		[button addTarget:self
				   action:@selector(selected:)
		 forControlEvents:UIControlEventTouchUpInside];
	}
	return button;
}

- (void)selected:(UIButton *)button {
	
	if (self.buttonDelegate && [self.buttonDelegate respondsToSelector:@selector(scrollBarButtonDidSelect:)]) {
		[self.buttonDelegate scrollBarButtonDidSelect:self];
	}
}

@end
