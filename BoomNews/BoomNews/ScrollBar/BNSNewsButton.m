//
//  BNSNewsButton.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsButton.h"

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
    
    self.politicsButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.entertainmentButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.sportsButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.gamesButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.historyButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.technologyButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	
    [_politicsButton setTitle:@"政务" forState:UIControlStateNormal];
    [_entertainmentButton setTitle:@"娱乐" forState:UIControlStateNormal];
    [_sportsButton setTitle:@"体育" forState:UIControlStateNormal];
    [_gamesButton setTitle:@"游戏" forState:UIControlStateNormal];
    [_historyButton setTitle:@"历史" forState:UIControlStateNormal];
    [_technologyButton setTitle:@"科技" forState:UIControlStateNormal];
	
	[self addSubview:_technologyButton];
    [self addSubview:_entertainmentButton];
    [self addSubview:_sportsButton];
    [self addSubview:_gamesButton];
    [self addSubview:_politicsButton];
    [self addSubview:_historyButton];
}


- (void)layout {

	[_politicsButton invalidateIntrinsicContentSize];
	[_entertainmentButton invalidateIntrinsicContentSize];
	[_sportsButton invalidateIntrinsicContentSize];
	[_gamesButton invalidateIntrinsicContentSize];
	[_historyButton invalidateIntrinsicContentSize];
	[_technologyButton invalidateIntrinsicContentSize];
	
	CGFloat perWidth = (CGRectGetWidth(self.bounds)) / 13.f;
//	_technologyButton.frame = CGRectMake(perWidth, 0, perWidth, 30);
//	_entertainmentButton.frame = CGRectMake(3 * perWidth, 0, perWidth, 30);
//	_sportsButton.frame = CGRectMake(5 * perWidth, 0, perWidth, 30);
//	_gamesButton.frame = CGRectMake(7 * perWidth , 0, perWidth, 30);
//	_politicsButton.frame = CGRectMake(9 * perWidth, 0, perWidth, 30);
//	_historyButton.frame = CGRectMake(11 * perWidth, 0, perWidth, 30);
	
	_technologyButton.layer.frame = CGRectMake(perWidth, 0, perWidth, 30);
	_entertainmentButton.layer.frame = CGRectMake(3 * perWidth, 0, perWidth, 30);
	_sportsButton.layer.frame = CGRectMake(5 * perWidth, 0, perWidth, 30);
	_gamesButton.layer.frame = CGRectMake(7 * perWidth , 0, perWidth, 30);
	_politicsButton.layer.frame = CGRectMake(9 * perWidth, 0, perWidth, 30);
	_historyButton.layer.frame = CGRectMake(11 * perWidth, 0, perWidth, 30);
	
//	NSLog(@"_technologyButton %@", NSStringFromCGRect(_technologyButton.frame));
//	NSLog(@"_entertainmentButton %@", NSStringFromCGRect(_entertainmentButton.frame));
//	NSLog(@"_sportsButton %@", NSStringFromCGRect(_sportsButton.frame));
//	NSLog(@"_gamesButton %@", NSStringFromCGRect(_gamesButton.frame));
//	NSLog(@"_politicsButton %@", NSStringFromCGRect(_politicsButton.frame));
//	NSLog(@"_historyButton %@", NSStringFromCGRect(_historyButton.frame));
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self layout];        
}




@end
