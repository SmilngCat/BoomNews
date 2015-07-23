//
//  Default.h
//  BoomNews
//
//  Created by jsix lei on 15/7/18.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#ifndef BoomNews_Default_h
#define BoomNews_Default_h

#import "Model.h"
#import "BNSNewsModel.h"
#import "BNSVideoModel.h"
#import "BNSMineModel.h"

#define NewsModel BNSNewsModel
#define VideoModel BNSVideoModel
#define MineModel BNSMineModel

#define kBNSTintFontNameChanged 0

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


/**
 *   请求的资源类型
 */
typedef NS_ENUM(NSInteger, BNSHTTPRequestResourceType){
	/**
	 *  科技
	 */
	BNSHTTPRequestResourceTypeTechnologyOfNews = 0,
	/**
	 *  娱乐
	 */
	BNSHTTPRequestResourceTypeEntertainmentOfNews,
	/**
	 *  体育
	 */
	BNSHTTPRequestResourceTypeSportsOfNews,
	/**
	 *  游戏
	 */
	BNSHTTPRequestResourceTypeGameOfNews,
	/**
	 *  政务
	 */
	BNSHTTPRequestResourceTypePolicyOfNews,
	/**
	 *  历史
	 */
	BNSHTTPRequestResourceTypeHistoryOfNews,
	/**
	 *  财经
	 */
	BNSHTTPRequestResourceTypeEconomicOfNews,
	/**
	 *  军事
	 */
	BNSHTTPRequestResourceTypeMilitaryOfNews,
	/**
	 *  彩票
	 */
	BNSHTTPRequestResourceTypeLotteryOfNews,
	/**
	 *  时尚
	 */
	BNSHTTPRequestResourceTypeFashionOfNews,
	
	/**
	 *	视频
	 */
	BNSHTTPRequestResourceTypeVideo = 100
};


#endif
