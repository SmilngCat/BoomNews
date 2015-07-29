//
//  LunBoView.h
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

//
//注意：在ViewDidLoad函数中调用[setNeedsLayout]和[layoutIfNeeded]方法
//

#import <UIKit/UIKit.h>

@class BNSScrollView;

@protocol BNSScrollViewDelegate <NSObject>

- (void)changeIndex;

@end


@interface BNSView : UIView

@property (copy, nonatomic) NSArray *images;
@property (retain, nonatomic) BNSScrollView *scrollView;
@property (assign, nonatomic) id<BNSScrollViewDelegate>bnsScrollDelegate;


- (void)bns_ConfigureScrollViewAtIndex:(NSUInteger)index count:(NSUInteger)count;
@end
