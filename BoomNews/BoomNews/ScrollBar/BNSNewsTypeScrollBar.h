//
//  NewsTypeScrollBar.h
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSNewsButton.h"

@interface BNSNewsTypeScrollBar : UIScrollView<UIScrollViewDelegate>

@property (retain, nonatomic) NSArray *datas;
@property (assign, nonatomic) id scrollBarButtonDelegate;


- (void)configureScrollViewAtIndex:(NSUInteger)index
							 count:(NSUInteger)count
						   options:(OrderDirectionType)options;

@end
