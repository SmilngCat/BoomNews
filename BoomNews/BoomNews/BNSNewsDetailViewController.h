//
//  BNSNewsDetailViewController.h
//  BoomNews
//
//  Created by 邵垚 on 15/7/21.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSDetailModel.h"
#import "BNSDetailWebModel.h"
@interface BNSNewsDetailViewController : UIViewController



@property (nonatomic, retain) BNSDetailModel *model;

@property (nonatomic, retain) BNSDetailWebModel *webModel;

@property (nonatomic, retain) BNSNewsModel *newsModel;
@end
