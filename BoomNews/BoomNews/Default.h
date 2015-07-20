//
//  Default.h
//  BoomNews
//
//  Created by jsix lei on 15/7/18.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#ifndef BoomNews_Default_h
#define BoomNews_Default_h

#import "BNSNewsModel.h"
#import "Model.h"

#define Absent @"absent.jpg"
#define NewsModel BNSNewsModel

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

#endif
