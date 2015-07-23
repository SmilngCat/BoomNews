//
//  BNSTableView+BNSHeightCache.h
//  BoomNews
//
//  Created by jsix lei on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView.h"

@interface BNSTableView (BNSHeightCache)

/**
 *  获取以identifier为重用标志的cell的高度
 *
 *  @param identifier cell的重用标识符
 *  @param configuration  配置cell
 *
 *  @return cell的高度
 */
- (CGFloat)heightForRowWithIdentifier:(NSString *)identifier
						configuration:(void(^)(id cell))configuration;

/**
 *  作用同heightForRowWithReuseIdentifier:configure:增加了缓冲功能
 *
 *  @param identifier cell的重用标识符
 *	@param indexPath  cell的位置
 *  @param configuration  配置cell
 *
 *  @return cell的高度
 */
- (CGFloat)heightForRowWithIdentifier:(NSString *)identifier
					cachedForIndexPath:(NSIndexPath *)indexPath
						configuration:(void(^)(id cell))configuration;

//缓存有效性标志
@property (assign, nonatomic) BOOL invalidate;

@end
