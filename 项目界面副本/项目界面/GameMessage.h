//
//  GameMessage.h
//  项目界面
//
//  Created by 邵垚 on 15/7/13.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
@interface GameMessage : NSObject


+ (GameMessage *)shareGameMessageManager;


- (void)requestData:(NSString *)strUrl completion:( void(^)(id) )completion;


- (NSInteger)modelCount;



@property (nonatomic, retain)NSMutableArray *dataArray;


@end
