//
//  BNSVideoModel.h
//  BoomNews
//
//  Created by jsix lei on 15/7/20.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNSVideoModel : NSObject

@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *m3u8_url;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *length;
@property (copy, nonatomic) NSString *playCount;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
