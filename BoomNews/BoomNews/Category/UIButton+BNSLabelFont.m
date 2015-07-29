//
//  UIButton+BNSLabelFont.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "UIButton+BNSLabelFont.h"

@implementation UIButton (BNSLabelFont)

+ (void)load {
	Method originMethod = class_getClassMethod(self, @selector(buttonWithType:));
	Method swizzledMethod = class_getClassMethod(self, @selector(bns_buttonWithType:));
	method_exchangeImplementations(originMethod, swizzledMethod);
}

+ (instancetype)bns_buttonWithType:(UIButtonType)type {
	UIButton *button = [self bns_buttonWithType:type];
	if (button) {
		NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
		NSString *size = fontDic[@"fontSize"];
		button.titleLabel.font = [UIFont fontWithName:fontDic[@"fontName"] size:size.integerValue];
	}
	return button;
}

@end
