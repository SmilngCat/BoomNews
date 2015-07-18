//
//  BNSNewsButton.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsButton.h"
#import "BNSNewsTypeScrollBarContentView.h"
@implementation BNSNewsButton

- (void)dealloc {
    
    [_politicsButton release];
    [_entertainmentButton release];
    [_sportsButton release];
    [_gamesButton release];
    [_historyButton release];
    [_technologyButton release];
    
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildLayout];
    }
    return self;
}


#pragma mark - Layout

- (void)buildLayout {
    
    self.politicsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.entertainmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sportsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gamesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.technologyButton = [UIButton buttonWithType:UIButtonTypeCustom];

	
    [_politicsButton setTitle:@"政务" forState:UIControlStateNormal];
    [_entertainmentButton setTitle:@"娱乐" forState:UIControlStateNormal];
    [_sportsButton setTitle:@"体育" forState:UIControlStateNormal];
    [_gamesButton setTitle:@"游戏" forState:UIControlStateNormal];
    [_historyButton setTitle:@"历史" forState:UIControlStateNormal];
    [_technologyButton setTitle:@"科技" forState:UIControlStateNormal];
    
    
    [self addSubview:_politicsButton];
    [self addSubview:_entertainmentButton];
    [self addSubview:_sportsButton];
    [self addSubview:_gamesButton];
    [self addSubview:_historyButton];
    [self addSubview:_technologyButton];
    
    
    
}







@end
