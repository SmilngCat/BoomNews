//
//  BNSVideoModel.m
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoModel.h"

@implementation BNSVideoModel

- (void)dealloc {
	
	[_cover release];
	[_m3u8_url release];
	[_title release];
	[_length release];
	[_playCount release];
	[super dealloc];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
	BNSVideoModel *model = [[[BNSVideoModel alloc] initWithDictionary:dic] autorelease];
	return model;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
	self = [super init];
	if (self) {
		[self setValuesForKeysWithDictionary:dic];
	}
	return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	
}
@end
