//
//  BNSMineView.h
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSDetailModel.h"
@class BNSMineViewController;

@interface BNSMineView : UIView

@property (assign, nonatomic) BNSMineViewController *viewController;


@property (retain, nonatomic) BNSDetailModel *model;

@end
