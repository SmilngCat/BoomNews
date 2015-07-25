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
		Class defaultCellClass = [UITableViewCell class];
		Class mutipleImageCellClass = [BNSMutipleImageCell class];
		Class singleImageCellClass = [BNSSingleImageCell class];
		Class titleCellClass = [BNSTitleCell class];
		Class videoCellClass = [BNSVideoCell class];
		
		[self registerClass:defaultCellClass forCellReuseIdentifier:NSStringFromClass(defaultCellClass)];
		[self registerClass:mutipleImageCellClass forCellReuseIdentifier:NSStringFromClass(mutipleImageCellClass)];
		[self registerClass:singleImageCellClass forCellReuseIdentifier:NSStringFromClass(singleImageCellClass)];
		[self registerClass:titleCellClass forCellReuseIdentifier:NSStringFromClass(titleCellClass)];
		[self registerClass:videoCellClass forCellReuseIdentifier:NSStringFromClass(videoCellClass)];
		
		//隐藏多余的cell
		UIView *footerView = [[[UIView alloc] init] autorelease];
		footerView.backgroundColor = [UIColor clearColor];
		self.tableFooterView = footerView;
		
		_offset = 0;
		_datas = [[NSMutableArray alloc] init];
	}
	return self;
}


- (BOOL)bns_LoadDataAtIndex:(NSUInteger)index
			  withURLString:(NSString *)urlString
				 completion:(void(^)(void))completion {
	
	__block typeof(self) weakSelf = self;
	BOOL result = [[BNSHTTPRequest sharedHTTPRequest] requestWithURLString:urlString
														type:index
												  completion:^(id data) {
													  
													  NSArray *dataArray = (NSArray *)data;
													  if (dataArray) {
														  for (id obj in dataArray) {
															  [weakSelf.datas addObject:obj];
														  }
													  }
													  
													  dispatch_async(dispatch_get_main_queue(), ^{
														  [self reloadData];
													  });
													  
													  !completion ?: completion();
												  }] ;

	return result;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
