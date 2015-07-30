//
//  NSMutableArray+DepthCopy.m
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "NSMutableArray+DepthCopy.h"

@implementation NSMutableArray (DepthCopy)

- (void)depthCopyWithMutableArray:(NSMutableArray *)array {
	if (!array) {
		return;
	}
	if (self == array) {
		return;
	}
	
	[self removeAllObjects];
	[array enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
		[self addObject:obj];
	}];
}

- (void)addObjectWithNoDumplicating:(NSMutableArray *)array {
	if (!array) {
		return;
	}

	__block BOOL duplicate = NO;
	for (id model in array) {
		[self enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
			if ([[obj title] isEqualToString:[model title]]) {
				duplicate = YES;
				*stop = YES;
			}
		}];
		if (!duplicate) {
			[self addObject:model];
		}else {
			duplicate = NO;
			continue;
		}
	}
}
@end
