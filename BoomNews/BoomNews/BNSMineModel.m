//
//  BNSMineModel.m
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineModel.h"

@implementation BNSMineModel


+ (instancetype)modelWithImage:(NSString *)image title:(NSString *)title {
	
	return [[[[self class] alloc] initWithImage:image title:title] autorelease];
}

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title {
	self = [super init];
	if (self) {
		_image = image;
		_title = title;
	}
	return self;
}
@end
