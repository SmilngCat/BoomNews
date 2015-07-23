//
//  BNSHTTPRequest.h
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestBlock)(id data);


@interface BNSHTTPRequest : NSObject

+ (instancetype)sharedHTTPRequest;

/**
 *  数据请求
 *
 *  @param urlString  网络地址字符串
 *  @param type       请求的资源类型
 *  @param completion 数据请求完成以后执行的block
 *
 *  @return YES请求成功，NO失败。
 */
- (BOOL)requestWithURLString:(NSString *)urlString
						type:(BNSHTTPRequestResourceType)type
				  completion:(RequestBlock)completion;
@end
