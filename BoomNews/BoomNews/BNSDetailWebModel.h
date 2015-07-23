//
//  BNSDetailWebModel.h
//  BoomNews
//
//  Created by 邵垚 on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNSDetailWebModel : NSObject
//非图片页面
//标题
@property (nonatomic, retain)NSString *title;
//来源
@property (nonatomic, retain)NSString *source;
//时间
@property (nonatomic, retain)NSString *ptime;
//内容
@property (nonatomic, retain)NSString *body;
//图片数组
@property (nonatomic, retain)NSArray *img;
//传的参数,归档用到
@property (nonatomic, copy)NSString *docid;




@end
