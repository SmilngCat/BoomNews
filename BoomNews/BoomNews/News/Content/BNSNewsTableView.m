//
//  BNSNewsEntertainmentTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTableView.h"
#import "BNSNewsDetailViewController.h"
@implementation BNSNewsTableView

#pragma mark - BNSTableView Lifecycle

- (void)dealloc {
	
	[super dealloc];
}

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
	
	NSString *tailString = [self.urlString substringWithRange:NSMakeRange(35, 14)];
	NSUInteger currentIndex = [self getCurrentIndexWithString:tailString];
	[self bns_LoadDataAtIndex:currentIndex completion:^{}];
	
	[self headerEndRefreshing];
}

- (void)footerRefreshing {
	
	__block typeof(self) weakSelf = self;
	static BOOL lock = NO;
	if (!lock) {
		lock = YES;
		dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
			//加载地址偏移量累加20
			weakSelf.offset += 20;
			
			NSString *tailString = [weakSelf.urlString substringWithRange:NSMakeRange(35, 14)];
			NSUInteger currentIndex = [weakSelf getCurrentIndexWithString:tailString];
			[weakSelf bns_LoadDataAtIndex:currentIndex completion:^{
				lock = NO;
			}];
		});
	}
	[self footerEndRefreshing];
}

- (NSUInteger)getCurrentIndexWithString:(NSString *)string {
	NSUInteger index = 0;
	if ([string isEqualToString:@"T1348649580692"]) {
		index = 0;
	}else if ([string isEqualToString:@"T1348648517839"]) {
		index = 1;
	}else if ([string isEqualToString:@"T1348649079062"]) {
		index = 2;
	}else if ([string isEqualToString:@"T1348654151579"]) {
		index = 3;
	}else if ([string isEqualToString:@"T1414142214384"]) {
		index = 4;
	}else if ([string isEqualToString:@"T1368497029546"]) {
		index = 5;
	}else if ([string isEqualToString:@"T1348648756099"]) {
		index = 6;
	}else if ([string isEqualToString:@"T1348648141035"]) {
		index = 7;
	}else if ([string isEqualToString:@"T1356600029035"]) {
		index = 8;
	}else if ([string isEqualToString:@"T1348650593803"]) {
		index = 9;
	}
	
	return index;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Class cellClass = [self recognizeClassForIndexPath:indexPath];
	BNSModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)
														 forIndexPath:indexPath];
	[self configureCell:cell forIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(BNSModelCell *)cell forIndexPath:(NSIndexPath *)indexPath {

	NewsModel *model = self.datas[indexPath.row];
	[cell setModel:model];
	
	[cell setNeedsLayout];
	[cell layoutIfNeeded];

}

- (Class)recognizeClassForIndexPath:(NSIndexPath *)indexPath {
	NewsModel *model = self.datas[indexPath.row];
	
	Class cellClass = NULL;
	if (indexPath.row == 0) {
		cellClass = [BNSTitleCell class];
	} else if (!model.imgextraArray) {
		cellClass = [BNSSingleImageCell class];
	}else {
		cellClass = [BNSMutipleImageCell class];
	}
	
	return cellClass;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Class cellClass = [self recognizeClassForIndexPath:indexPath];
	
	CGFloat height = [self heightForRowWithIdentifier:NSStringFromClass(cellClass)
								   cachedForIndexPath:indexPath
										configuration:^(id cell) {
		
		[self configureCell:cell forIndexPath:indexPath];
	}];
	
	return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BNSNewsDetailViewController *detailVC = [[BNSNewsDetailViewController alloc]init];
    
    
    detailVC.model = self.datas[indexPath.row];
   
    
    detailVC.hidesBottomBarWhenPushed = YES;
    
    
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
    
    [detailVC release];
    
    
}
@end
