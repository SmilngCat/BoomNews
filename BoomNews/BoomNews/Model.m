//
//  Model.m
//  项目界面
//
//  Created by 邵垚 on 15/7/13.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "Model.h"
#import "Model2.h"
@implementation Model


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"imgextra"]) {
		
        self.imgextraArray = [NSMutableArray array];
		
        for (NSDictionary *dic in value) {
            Model2 *model = [[Model2 alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.imgextraArray addObject:model];
            [model release];
        }
    }
}




@end
