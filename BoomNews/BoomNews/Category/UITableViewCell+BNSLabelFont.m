//
//  UITableViewCell+BNSLabelFont.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "UITableViewCell+BNSLabelFont.h"


@implementation UITableViewCell (BNSLabelFont)

+ (void)load {
	Method originMethod = class_getInstanceMethod(self, @selector(initWithStyle:reuseIdentifier:));
	Method swizzledMethod = class_getInstanceMethod(self, @selector(bns_initWithStyle:reuseIdentifier:));
	method_exchangeImplementations(originMethod, swizzledMethod);
	
	Method originMethodD = class_getInstanceMethod(self, @selector(dealloc));
	Method swizzledMethodD = class_getInstanceMethod(self, @selector(bns_dealloc));
	method_exchangeImplementations(originMethodD, swizzledMethodD);
}


- (instancetype)bns_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {
	[self bns_initWithStyle:style reuseIdentifier:identifier];
	if (self) {
		NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForMutableKey:@"TintFont"];
		NSString *size = fontDic[@"fontSize"];
		self.textLabel.font = [UIFont fontWithName:fontDic[@"fontName"] size:size.integerValue];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontChanged:) name:kBNSTintFontChanged object:nil];

	}
	return self;
}

- (void)bns_dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self bns_dealloc];
}


#pragma mark - Actions

- (void)fontChanged:(NSNotification *)notification {
	NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
	UIFont *currentFont = [UIFont fontWithName:fontDic[@"fontName"] size:[fontDic[@"fontSize"] integerValue]];
	
	self.textLabel.font = currentFont;
}



@end
