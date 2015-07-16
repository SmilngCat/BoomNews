//
//  BNSTableView+BNSTemplateCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView+BNSTemplateCell.h"

@implementation BNSTableView (BNSTemplateCell)

- (BNSModelCell *)bns_templateCellWithIdentifier:(NSString *)identifier {
	NSMutableDictionary *templates = objc_getAssociatedObject(self, _cmd);
	if (!templates) {
		templates = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self,
								 _cmd,
								 templates,
								 OBJC_ASSOCIATION_RETAIN);
	}
	
	BNSModelCell *cell = templates[identifier];
	if (!cell) {
		cell = [self dequeueReusableCellWithIdentifier:identifier];
		NSAssert(cell, @"dequeueReusableCell needs rigister first.");
		cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
		templates[identifier] = cell;
	}
	
	return cell;
}

@end
