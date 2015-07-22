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
	}
	return self;
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
