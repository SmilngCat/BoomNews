//
//  BNSModeCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/15.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSModelCell.h"

@implementation BNSModelCell

- (void)dealloc {
	
	[_model release];
	[super dealloc];
}

@end
