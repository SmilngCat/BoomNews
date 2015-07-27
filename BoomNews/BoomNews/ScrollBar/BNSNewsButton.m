//
//  BNSNewsButton.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsButton.h"

#define WIDTH_NEWSTYPEBAR 50
#define HEIGHT_NEWSTYPEBAR 30



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
		[self buildLayout:frame];
    }
    return self;
}


#pragma mark - Layout

- (void)buildLayout:(CGRect)frame {
    
    self.politicsButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.entertainmentButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.sportsButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.gamesButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.historyButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
    self.technologyButton = [BNSNewsTypeScrollBarButton buttonWithType:UIButtonTypeCustom];
	
	CGFloat gap_Len = (CGRectGetWidth(frame) - 6 * WIDTH_NEWSTYPEBAR) / 7.f;
	CGFloat part_Len = gap_Len + WIDTH_NEWSTYPEBAR;
	
	_technologyButton.layer.frame = CGRectMake(gap_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_entertainmentButton.layer.frame = CGRectMake(gap_Len + part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_sportsButton.layer.frame = CGRectMake(gap_Len + 2*part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_gamesButton.layer.frame = CGRectMake(gap_Len + 3*part_Len , 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_politicsButton.layer.frame = CGRectMake(gap_Len + 4*part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_historyButton.layer.frame = CGRectMake(gap_Len + 5*part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	
	[_technologyButton setTitle:@"科技" forState:UIControlStateNormal];
	[_entertainmentButton setTitle:@"娱乐" forState:UIControlStateNormal];
    [_sportsButton setTitle:@"体育" forState:UIControlStateNormal];
    [_gamesButton setTitle:@"游戏" forState:UIControlStateNormal];
	[_politicsButton setTitle:@"政务" forState:UIControlStateNormal];
    [_historyButton setTitle:@"历史" forState:UIControlStateNormal];
	
	_technologyButton.index = 0;
	_entertainmentButton.index = 1;
	_sportsButton.index = 2;
	_gamesButton.index = 3;
	_politicsButton.index = 4;
	_historyButton.index = 5;
	
	//当前选中类型
	[_entertainmentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	
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
	
//	_technologyButton.frame = CGRectMake(perWidth, 0, perWidth, 30);
//	_entertainmentButton.frame = CGRectMake(3 * perWidth, 0, perWidth, 30);
//	_sportsButton.frame = CGRectMake(5 * perWidth, 0, perWidth, 30);
//	_gamesButton.frame = CGRectMake(7 * perWidth , 0, perWidth, 30);
//	_politicsButton.frame = CGRectMake(9 * perWidth, 0, perWidth, 30);
//	_historyButton.frame = CGRectMake(11 * perWidth, 0, perWidth, 30);
	
	CGFloat gap_Len = (CGRectGetWidth(self.bounds) - 6 * WIDTH_NEWSTYPEBAR) / 7.f;
	CGFloat part_Len = gap_Len + WIDTH_NEWSTYPEBAR;
	
	_technologyButton.layer.frame = CGRectMake(gap_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_entertainmentButton.layer.frame = CGRectMake(gap_Len + part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_sportsButton.layer.frame = CGRectMake(gap_Len + 2*part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_gamesButton.layer.frame = CGRectMake(gap_Len + 3*part_Len , 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_politicsButton.layer.frame = CGRectMake(gap_Len + 4*part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_historyButton.layer.frame = CGRectMake(gap_Len + 5*part_Len, 0, WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self layout];        
}




@end
