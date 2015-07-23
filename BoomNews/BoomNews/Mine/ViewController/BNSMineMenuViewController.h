//
//  BNSMineMenuViewController.h
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

//选项列表类

#import <UIKit/UIKit.h>

typedef void(^BNSThen)(id obj);

@interface BNSMineMenuViewController : UIViewController

@property (assign, nonatomic) NSUInteger index;
@property (copy, nonatomic) NSArray *datas;
@property (copy, nonatomic) BNSThen then;
@end
