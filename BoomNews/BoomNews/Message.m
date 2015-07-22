//
//  Message.m
//  18.网络请求2
//
//  Created by 邵垚 on 15/6/16.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "Message.h"
static Message *message = nil;
@implementation Message



+ (Message *)shareMessageManager{



    
    @synchronized(self){
        if (!message) {
            message = [[Message alloc]init];
            
        }
        return message;
    
    }
    
}


+ (void)recivedDataWithURLString:(NSString *)urlString method:(NSString *)method body:(NSString *)body Block:(Block)block{

    //1.转成URL
    NSURL *url = [NSURL URLWithString:urlString];
    //2.准备request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //3.设置请求方式Method
    [request setHTTPMethod:method];
    //判断，请求方式（以Method传进来的值为判断依据）
    
    
    if ([method isEqualToString:@"POST"]) {
        NSData *returnData = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:returnData];
    }
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id tempObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //使用block将此对象传回到视图控制器类里面
        
        block(tempObj);
        
    }];

    
    
    

}





@end
