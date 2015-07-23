//
//  NewsTypeScrollBarButton.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBarButton.h"

@implementation BNSNewsTypeScrollBarButton

- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

+ (instancetype)buttonWithType:(UIButtonType)type {
	BNSNewsTypeScrollBarButton *button= [super buttonWithType:type];
	if (button) {
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		button.translatesAutoresizingMaskIntoConstraints = NO;
		[button addTarget:button
				   action:@selector(buttonClicked:)
		 forControlEvents:UIControlEventTouchUpInside];
		
		[[NSNotificationCenter defaultCenter] addObserver:button selector:@selector(fontChanged:) name:kBNSTintFontChanged object:nil];
	}
	return button;
}

#pragma mark - Notification

- (void)fontChanged:(NSNotification *)notification {
	NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
	UIFont *currentFont = [UIFont fontWithName:fontDic[@"fontName"] size:[fontDic[@"fontSize"] integerValue]];
	
	self.titleLabel.font = currentFont;
}

#pragma mark - Actions

- (void)buttonClicked:(UIButton *)button {
	
	if (self.buttonDelegate && [self.buttonDelegate respondsToSelector:@selector(scrollBarButtonDidSelect:)]) {
		[self.buttonDelegate scrollBarButtonDidSelect:self];
	}
}

@end
