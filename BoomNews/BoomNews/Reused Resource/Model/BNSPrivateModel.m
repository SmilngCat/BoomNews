//
//  BNSPrivateModel.m
//  BoomNews
//
//  Created by jsix lei on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSPrivateModel.h"

@implementation BNSPrivateModel

- (void)dealloc {
	[_imgsrc release];
	[super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}
@end
