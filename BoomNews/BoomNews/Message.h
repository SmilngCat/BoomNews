//
//  Message.h
//  18.网络请求2
//
//  Created by 邵垚 on 15/6/16.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(id object);

@interface Message : NSObject



//声明数据请求方法,将post和get请求写进一个方法里，判断method（请求类型）

+ (void)recivedDataWithURLString:(NSString *)urlString method:(NSString *)method body:(NSString *)body Block:(Block)block;





+ (Message *)shareMessageManager;




@end
