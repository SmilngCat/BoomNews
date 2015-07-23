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
- (void)requestWithURLString:(NSString *)urlString
						type:(BNSHTTPRequestResourceType)type
				  completion:(RequestBlock)completion;
@end
