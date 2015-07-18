//
//  BNSNewsModel.m
//  BoomNews
//
//  Created by jsix lei on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsModel.h"
#import "BNSPrivateModel.h"

@implementation BNSNewsModel

- (void)dealloc {
	
	[_title release];
	[_digest release];
	[_imgsrc release];
	[_editorArray release];
	[_imgextraArray release];
	
	[super dealloc];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
	BNSNewsModel *model = [[[BNSNewsModel alloc] initWithDictionary:dic] autorelease];
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
	
	if ([key isEqualToString:@"imgextra"]) {
		
		NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
		
		for (NSDictionary *dic in value) {
			BNSPrivateModel *model = [[BNSPrivateModel alloc] init];
			[model setValuesForKeysWithDictionary:dic];
			[tmpArray addObject:model];
			[model release];
		}
		self.imgextraArray = tmpArray;
		[tmpArray release];
	}
}

@end
