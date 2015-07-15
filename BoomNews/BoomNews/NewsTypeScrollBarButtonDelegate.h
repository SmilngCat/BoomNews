//
//  NewsTypeScrollBarButtonDelegate.h
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNSNewsTypeScrollBarButton;

@protocol BNSNewsTypeScrollBarButtonDelegate <NSObject>

- (void)scrollBarButtonDidSelect:(BNSNewsTypeScrollBarButton *)button;
@end
