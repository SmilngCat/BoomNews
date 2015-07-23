//
//  UILabel+BNSLabelFont.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "UILabel+BNSLabelFont.h"

@implementation UILabel (BNSLabelFont)

+ (void)load {
	Method originMethod = class_getInstanceMethod(self, @selector(initWithFrame:));
	Method swizzledMethod = class_getInstanceMethod(self, @selector(bns_initWithFrame:));
	method_exchangeImplementations(originMethod, swizzledMethod);
}

- (instancetype)bns_initWithFrame:(CGRect)frame {
	[self bns_initWithFrame:frame];
	if (self) {
		NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
		NSNumber *size = fontDic[@"fontSize"];
		self.font = [UIFont fontWithName:fontDic[@"fontName"] size:size.integerValue];
	}
	return self;
}

- (void)changeFont {
	if (self) {
		NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
		NSNumber *size = fontDic[@"fontSize"];
		self.font = [UIFont fontWithName:fontDic[@"fontName"] size:size.integerValue];
	}
}


@end
