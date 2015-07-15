//
//  NewsTypeScrollBarButton.h
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsTypeScrollBarButtonDelegate;

@interface NewsTypeScrollBarButton : UIButton

@property (assign, nonatomic) id<NewsTypeScrollBarButtonDelegate> buttonDelegate;
@end
