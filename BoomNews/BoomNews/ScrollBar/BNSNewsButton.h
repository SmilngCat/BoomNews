//
//  BNSNewsButton.h
//  BoomNews
//
//  Created by 邵垚 on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSNewsTypeScrollBarButton.h"

@interface BNSNewsButton : UIView

@property (retain, nonatomic) BNSNewsTypeScrollBarButton *technologyButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *entertainmentButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *sportsButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *gamesButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *politicsButton;
@property (retain, nonatomic) BNSNewsTypeScrollBarButton *historyButton;

@end
