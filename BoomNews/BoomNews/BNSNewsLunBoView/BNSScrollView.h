//
//  LunBoScrollView.h
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNSScrollContentView;

@interface BNSScrollView : UIScrollView

@property (retain, nonatomic) BNSScrollContentView *contentView;
@end
