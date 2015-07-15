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
        Model2 *model = [[Model2 alloc]init];
        NSLog(@"%@" , value);
        for (NSDictionary *dic in value) {
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@" , model);
            [self.imgextraArray addObject:model];
            
            //NSLog(@"+++++%@", [self.imgextraArray[1] objectForKey:@"imgsrc"]);
            [model release];
        }
        //NSLog(@"%@ ", [self.imgextraArray[0] imgsrc]);
        NSLog(@"%@" , [model imgsrc]);
    }
}




@end
