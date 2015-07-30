//
//  BNSVideoTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoTableView.h"
#import "BNSVideoCell.h"

#import "NSMutableArray+DepthCopy.h"
#import "BNSTableView+BNSTemplateCell.h"
#import "BNSTableView+BNSHeightCache.h"

#import "BNSWaitingViewController.h"

@interface BNSVideoTableView ()

@property (assign, nonatomic) dispatch_semaphore_t semaphore;
@end

@implementation BNSVideoTableView

#pragma mark - BNSTableView Lifecycle

- (void)dealloc {
	
	dispatch_release(_semaphore);
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	self = [super initWithFrame:frame style:style];
	if (self) {
		self.dataSource = self;
		self.delegate = self;
		
		_semaphore = dispatch_semaphore_create(0);
		
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
	
	NSString *urlString = [self.urlString stringByAppendingFormat:@"/%ld-%d.html", self.offset, 10];
	
	__block typeof(self) weakSelf = self;
	[self bns_LoadDataAtIndex:BNSHTTPRequestResourceTypeVideo withURLString:urlString cache:NO completion:^{
		//加载地址偏移量累加10
		weakSelf.offset += 10;
		
		NSString *urlString = [weakSelf.urlString stringByAppendingFormat:@"/%ld-%d.html", weakSelf.offset, 10];
		[weakSelf bns_LoadDataAtIndex:BNSHTTPRequestResourceTypeVideo withURLString:urlString cache:YES completion:^{
			weakSelf.cacheValidate = YES;
			dispatch_semaphore_signal(_semaphore);
		}];

	}];
	
	[self headerEndRefreshing];
}

- (void)footerRefreshing {
	
	long success = dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC));
	
	//超时
	if (success) {
		[self footerEndRefreshing];
		return;
	}

	if (self.cacheValidate) {
		//加载缓存数据
		[self.datas addObjectWithNoDumplicating:self.cache1];
		[self.cache1 removeAllObjects];
		
		//更新View
		[self reloadData];
		
		//再缓存
		self.cacheValidate = NO;
		[self updateDataIfNeeded];
	}

	[self footerEndRefreshing];
}

- (void)updateDataIfNeeded {
	//加载地址偏移量累加10
	self.offset += 10;
	
	NSString *urlString = [self.urlString stringByAppendingFormat:@"/%ld-%d.html",self.offset, 10];
	[self bns_LoadDataAtIndex:BNSHTTPRequestResourceTypeVideo withURLString:urlString cache:YES completion:^{
		self.cacheValidate = YES;
		dispatch_semaphore_signal(_semaphore);
	}];

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
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{});
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.f;
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
