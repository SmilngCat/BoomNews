//
//  NewsTypeScrollBarButton.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "NewsTypeScrollBarButton.h"
#import "NewsTypeScrollBarButtonDelegate.h"

@implementation NewsTypeScrollBarButton

+ (instancetype)buttonWithType:(UIButtonType)type {
	NewsTypeScrollBarButton *button= [super buttonWithType:type];
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
