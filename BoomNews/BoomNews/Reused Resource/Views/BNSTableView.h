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



@interface BNSTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) UIViewController *viewController;
@property (copy, nonatomic) NSString *urlString;
@property (copy, nonatomic) NSArray *datas;

- (void)bns_LoadData:(NSUInteger)index;
@end
