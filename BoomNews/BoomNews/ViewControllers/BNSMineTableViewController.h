//
//  BNSMineTableViewController.h
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNSMineTableViewController : UITableViewController

//返回时隐藏导航栏
@property (assign, nonatomic) BOOL hiddenNavigationBar;
@property (copy, nonatomic) NSArray *datas;
@end
