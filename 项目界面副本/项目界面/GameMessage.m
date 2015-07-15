//
//  GameMessage.m
//  项目界面
//
//  Created by 邵垚 on 15/7/13.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "GameMessage.h"

@implementation GameMessage
- (void)dealloc
{
    [_dataArray release];
    [super dealloc];
}

+ (GameMessage *)shareGameMessageManager{


    static GameMessage *gameMessage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gameMessage = [[GameMessage alloc]init];
    });

    return gameMessage;


}

- (NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }

    return _dataArray;

}


- (void)requestData:(NSString *)strUrl completion:(void (^)(id))completion{

    NSURL *url = [NSURL URLWithString:strUrl];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    __block typeof(self)aSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"T1348654151579"];
        for (NSDictionary *dic in array) {
            Model *model = [[Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [aSelf.dataArray addObject:model];
            [model release];
        }

        
        if (completion) {
            completion(self.dataArray);
        }
    }];

    
}




@end
