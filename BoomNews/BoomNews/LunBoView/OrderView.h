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
#import "OrderScrollView.h"

@interface OrderView : UIView

@property (copy, nonatomic) NSArray *datas;
@property (retain, nonatomic) OrderScrollView *scrollView;
@property (assign, nonatomic) UIViewController *viewController;
/**
 *  给轮播图中间的视图配置数据
 *
 *  @param index   中间视图在数据源datas中得当前下标
 *  @param count   当前数据原数组datas的大小
 *  @param options 滚动方向
 */

- (void)scrollViewDidEndScrollAtIndex:(NSUInteger)index
								count:(NSUInteger)count
							  options:(OrderDirectionType)options;

- (void)configureScrollViewAtIndex:(NSUInteger)index
							 count:(NSUInteger)count
						   options:(OrderDirectionType)options;
@end
