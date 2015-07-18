//
//  BNSNewsModel.h
//  BoomNews
//
//  Created by jsix lei on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNSNewsModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *digest;
@property (copy, nonatomic) NSString *imgsrc;
@property (copy, nonatomic) NSArray *editorArray;
@property (copy, nonatomic) NSArray *imgextraArray;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
