//
//  BNSNewsDetailView.h
//  BoomNews
//
//  Created by 邵垚 on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSDetailModel.h"

@interface BNSNewsDetailView : UIScrollView


@property (nonatomic, retain) UILabel *titleLabel;


@property (nonatomic, retain) UILabel *digestLabel;

@property (nonatomic, retain) UILabel *picSumLabel;


@property (nonatomic, retain) BNSDetailModel *model;


@end
