//
//  BNSTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView.h"

@implementation BNSTableView

- (void)dealloc {
	objc_setAssociatedObject(self,
							 @selector(bns_templateCellWithIdentifier:),
							 nil, OBJC_ASSOCIATION_RETAIN);
	[super dealloc];
}
@end
