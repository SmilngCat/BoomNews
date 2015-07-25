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

#import "BNSWaitingViewController.h"

@implementation BNSVideoTableView

#pragma mark - BNSTableView Lifecycle


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	self = [super initWithFrame:frame style:style];
	if (self) {
		self.dataSource = self;
		self.delegate = self;
		
		//refreshing
		[self addHeaderWithTarget:self action:@selector(headerRefreshing)];
		[self addFooterWithTarget:self action:@selector(footerRefreshing)];
	}
	return self;
}

#pragma mark - Refreshing

- (void)headerRefreshing {

	//清空数据源数组
	[self.datas removeAllObjects];
	//清空缓存区
	self.invalidate = YES;
	//清空tableView
	[self reloadData];
	
	//加载地址偏移量回到0
	self.offset = 0;
	
	[self bns_LoadDataAtIndex:BNSHTTPRequestResourceTypeVideo completion:^{
	}];
	
	[self headerEndRefreshing];
}

- (void)footerRefreshing {
	
	static BOOL lock = NO;
	if (!lock) {
		
		dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
			lock = YES;
			//加载地址偏移量累加20
			self.offset += 20;
			
			lock = ![self bns_LoadDataAtIndex:BNSHTTPRequestResourceTypeVideo completion:^{
				lock = NO;
			}];
		});
	}
	[self footerEndRefreshing];
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
