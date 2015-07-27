//
//  NSUserDefaults+Mutable.h
//  BoomNews
//
//  Created by jsix lei on 15/7/24.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Mutable)

- (BOOL)boolForMutableKey:(NSString *)key;
- (void)setBool:(BOOL)value forMutableKey:(NSString *)key;

- (NSInteger)integerForMutableKey:(NSString *)key;
- (void)setInteger:(NSInteger)value forMutableKey:(NSString *)key;

- (id)objectForMutableKey:(NSString *)key;
- (void)setObject:(id)value forMutableKey:(NSString *)key;
@end
