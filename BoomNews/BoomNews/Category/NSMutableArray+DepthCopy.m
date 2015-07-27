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
@end
