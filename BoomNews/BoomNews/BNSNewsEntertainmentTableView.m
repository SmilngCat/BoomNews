//
//  BNSNewsEntertainmentTableView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsEntertainmentTableView.h"

@interface BNSNewsEntertainmentTableView ()

@property (copy, nonatomic) NSArray *datas;
@end


@implementation BNSNewsEntertainmentTableView

#pragma mark - BNSTableView Lifecycle

- (void)dealloc {
	
	[_datas release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	self = [super initWithFrame:frame style:style];
	if (self) {
		self.dataSource = self;
		self.delegate = self;
		NSString *urlString = @"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html";
		[[BNSHTTPRequest sharedHTTPRequest] requestWithURLString:urlString
															type:BNSHTTPRequestResourceTypeEntertainmentOfNews
														httpBody:nil completion:^(id data) {
			_datas = [data copy];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self reloadData];
			});
		}] ;
	}
	return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Class cellClass = [self recognizeClassForIndexPath:indexPath];
	BNSModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)
														 forIndexPath:indexPath];
	[self configureCell:cell forIndexPath:indexPath];
	
	return cell;
}

- (void)configureCell:(BNSModelCell *)cell forIndexPath:(NSIndexPath *)indexPath {
	
	Model *model = _datas[indexPath.row];
	[cell setModel:model];
}

- (Class)recognizeClassForIndexPath:(NSIndexPath *)indexPath {
	Model *model = _datas[indexPath.row];
	
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
	BNSModelCell *cell = [self bns_templateCellWithIdentifier:NSStringFromClass(cellClass)];
	[self configureCell:cell forIndexPath:indexPath];

	[cell setNeedsLayout];
	[cell layoutIfNeeded];
	
	return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.0 / [UIScreen mainScreen].scale;
}


@end
