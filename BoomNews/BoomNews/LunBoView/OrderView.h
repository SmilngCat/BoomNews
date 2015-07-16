//
//  LunBoView.h
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

//
//注意：在ViewDidLoad函数中调用[setNeedsLayout]和[layoutIfNeeded]方法
//

#import <UIKit/UIKit.h>

@class OrderScrollView;

@interface OrderView : UIView

@property (copy, nonatomic) NSArray *images;
@property (retain, nonatomic) OrderScrollView *scrollView;

- (void)configureScrollViewAtIndex:(NSUInteger)index count:(NSUInteger)count;
@end
