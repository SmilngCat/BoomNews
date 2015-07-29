//
//  NewsTypeScrollBar.h
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSNewsTypeScrollBarButton.h"

@interface BNSNewsTypeScrollBarContentView : UIView

@property (retain, nonatomic) BNSNewsTypeScrollBarButton *politicsButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *entertainmentButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *sportsButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *gamesButton;
@end
