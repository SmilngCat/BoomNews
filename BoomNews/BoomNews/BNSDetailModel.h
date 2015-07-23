//
//  BNSDetailModel.h
//  BoomNews
//
//  Created by 邵垚 on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNSDetailModel : NSObject



@property (copy, nonatomic) NSString *skipID;

@property (copy, nonatomic) NSString *docid;

@property (copy, nonatomic) NSString *imgsum;//详情界面的图片数量

@property (copy, nonatomic) NSString *imgurl;//详情界面的大图

@property (copy, nonatomic) NSString *imgtitle;//详情界面的介绍

@property (copy, nonatomic) NSString *setname;//详情界面标题

@property (copy, nonatomic) NSString *note;

@property (copy, nonatomic) NSString *skipType;//特殊的类型

@property (copy, nonatomic) NSString *specialID;//特殊的ID


@end
