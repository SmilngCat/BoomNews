//
//  NewsTypeScrollBar.h
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSNewsButton.h"

/**
 *  轮播图滚动方向
 */
typedef NS_ENUM(NSUInteger, OrderDirectionType){
    /**
     *  未滚动
     */
    OrderDirectionTypeNone = 0,
    /**
     *  向左滚动
     */
    OrderDirectionTypeLeft,
    /**
     *  向右滚动
     */
    OrderDirectionTypeRight
};

@interface BNSNewsTypeScrollBar : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, retain)NSArray *datas;
@property (retain, nonatomic) BNSNewsButton *contentButton;


- (void)configureScrollViewAtIndex:(NSUInteger)index
							 count:(NSUInteger)count
						   options:(OrderDirectionType)options;

@end
