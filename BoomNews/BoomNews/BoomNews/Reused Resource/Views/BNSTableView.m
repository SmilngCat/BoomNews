//
//  BNSTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView.h"
#import "BNSTableView+BNSTemplateCell.h"
#import "BNSTableView+BNSHeightCache.h"

@implementation BNSTableView 

#pragma mark - BNSTableView Lifecycle

- (void)dealloc {
	objc_setAssociatedObject(self,
							 @selector(bns_templateCellWithIdentifier:),
							 nil, OBJC_ASSOCIATION_RETAIN);
	objc_setAssociatedObject(self, @selector(cache), nil, OBJC_ASSOCIATION_RETAIN);
	objc_setAssociatedObject(self, @selector(precacheEnabled), nil, OBJC_ASSOCIATION_RETAIN);
	objc_setAssociatedObject(self, @selector(invalidate), nil, OBJC_ASSOCIATION_RETAIN);
	[_datas release];
	[_urlString release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	self = [super initWithFrame:frame style:style];
	if (self) {
		Class mutipleImageCellClass = [BNSMutipleImageCell class];
		Class singleImageCellClass = [BNSSingleImageCell class];
		Class titleCellClass = [BNSTitleCell class];
		
		[self registerClass:mutipleImageCellClass forCellReuseIdentifier:NSStringFromClass(mutipleImageCellClass)];
		[self registerClass:singleImageCellClass forCellReuseIdentifier:NSStringFromClass(singleImageCellClass)];
		[self registerClass:titleCellClass forCellReuseIdentifier:NSStringFromClass(titleCellClass)];
		
	}
	return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
