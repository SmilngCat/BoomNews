//
//  BNSTableView.h
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//


/**
 *  新闻视图中所有的tableView均使用此类
 */

#import <UIKit/UIKit.h>
#import "BNSHTTPRequest.h"
#import "BNSModelCell.h"
#import "BNSMutipleImageCell.h"
#import "BNSSingleImageCell.h"
#import "BNSTitleCell.h"
#import "BNSVideoCell.h"

//刷新
#import "MJRefresh.h"


@interface BNSTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) UIViewController *viewController;

//数据请求的基地址,例如@"http://c.m.163.com/nc/article/list/T1348649580692"
@property (copy, nonatomic) NSString *urlString;
//加载数据的偏移量,默认从0开始
@property (assign, nonatomic) NSUInteger offset;

//保存数据的数组
@property (retain, nonatomic) NSMutableArray *datas;

//数据加载方法
- (void)bns_LoadData:(NSUInteger)index;
@end
