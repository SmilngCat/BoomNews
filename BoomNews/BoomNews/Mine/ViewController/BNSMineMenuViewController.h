//
//  BNSMineMenuViewController.h
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

//选项列表类

#import <UIKit/UIKit.h>

typedef void(^BNSThen)(NSUInteger obj);

@interface BNSMineMenuViewController : UIViewController

//设置字体大小还是类型，0为类型，1为大小
@property (assign, nonatomic) NSUInteger index;
//familyName
@property (assign, nonatomic) NSUInteger family;

@property (copy, nonatomic) NSArray *datas;
@property (copy, nonatomic) BNSThen then;
@end
