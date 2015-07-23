//
//  BNSMineModel.h
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNSMineModel : NSObject

@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *title;

+ (instancetype)modelWithImage:(NSString *)image title:(NSString *)title;
- (instancetype)initWithImage:(NSString *)image title:(NSString *)title;
@end
