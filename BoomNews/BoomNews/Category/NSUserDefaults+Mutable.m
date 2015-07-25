//
//  NSUserDefaults+Mutable.m
//  BoomNews
//
//  Created by jsix lei on 15/7/24.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "NSUserDefaults+Mutable.h"

@implementation NSUserDefaults (Mutable)

//bool
- (BOOL)boolForMutableKey:(NSString *)key {
	return [self boolForKey:key];
}

- (void)setBool:(BOOL)value forMutableKey:(NSString *)key {
	[self removeObjectForKey:key];
	[self setBool:value forKey:key];
}

//NSInteger
- (NSInteger)integerForMutableKey:(NSString *)key {
	return [self integerForKey:key];
}

- (void)setInteger:(NSInteger)value forMutableKey:(NSString *)key {
	[self removeObjectForKey:key];
	[self setInteger:value forKey:key];
}

//id
- (id)objectForMutableKey:(NSString *)key {
	return [self objectForKey:key];
}

- (void)setObject:(id)value forMutableKey:(NSString *)key {
	[self removeObjectForKey:key];
	[self setObject:value forKey:key];
}
@end
