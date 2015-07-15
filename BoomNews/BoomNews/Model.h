//
//  NewsListSingleImageCellModel.h
//  BoomNews
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *digest;
@property (nonatomic, copy) NSString *imgsrc;
@property (nonatomic, retain)NSMutableArray *imgextraArray;



+ (instancetype)modelWithProfile:(NSString *)profile
						   title:(NSString *)title
						   digest:(NSString *)digest
							 ima:(NSMutableArray *)ima;

- (instancetype)initWithProfile:(NSString *)profile
						   title:(NSString *)title
						  digest:(NSString *)digest
							ima:(NSMutableArray *)ima;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;
@end
