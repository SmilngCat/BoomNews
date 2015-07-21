//
//  BNSVideoTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoTableView.h"
#import "BNSVideoCell.h"
#import "BNSTableView+BNSTemplateCell.h"
#import "BNSTableView+BNSHeightCache.h"

@implementation BNSVideoTableView

#pragma mark - BNSTableView Lifecycle

- (void)dealloc {
	
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	self = [super initWithFrame:frame style:style];
	if (self) {
		self.dataSource = self;
		self.delegate = self;
	}
	return self;
}


#pragma mark - UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	BNSVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BNSVideoCell class])
														 forIndexPath:indexPath];
	[self configureCell:cell forIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(BNSVideoCell *)cell forIndexPath:(NSIndexPath *)indexPath {
	
	VideoModel *model = self.datas[indexPath.row];
	[cell setModel:model];
	
	[cell setNeedsLayout];
	[cell layoutIfNeeded];
	
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	CGFloat height = [self heightForRowWithIdentifier:NSStringFromClass([BNSVideoCell class])
								   cachedForIndexPath:indexPath
										configuration:^(id cell) {
											
											[self configureCell:cell forIndexPath:indexPath];
										}];
	
	return height;
}

@end
