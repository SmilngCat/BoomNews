//
//  LunBoScrollContentView.h
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNSNewsTableView.h"

#define ContentView BNSNewsTableView



@interface OrderScrollContentView : UIView

@property (retain, nonatomic) ContentView *leftView;
@property (retain, nonatomic) ContentView *middleView;
@property (retain, nonatomic) ContentView *rightView;
@end
