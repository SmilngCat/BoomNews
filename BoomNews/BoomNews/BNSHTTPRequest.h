//
//  BNSHTTPRequest.h
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestBlock)(id data);

/**
 *   请求的资源类型
 */
typedef NS_ENUM(NSInteger, BNSHTTPRequestResourceType){
	/**
	 *  娱乐
	 */
	BNSHTTPRequestResourceTypeEntertainmentOfNews = 0,
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
	BNSHTTPRequestResourceTypePolicyOfNews
};


@interface BNSHTTPRequest : NSObject

+ (instancetype)sharedHTTPRequest;
- (void)requestWithURLString:(NSString *)urlString
						type:(BNSHTTPRequestResourceType)type
					httpBody:(NSData *)httpBody
				  completion:(RequestBlock)completion;
@end