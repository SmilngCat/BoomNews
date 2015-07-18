//
//  RootViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsViewController.h"

#import "OrderView.h"

#import "BNSNewsTypeScrollBar.h"
#import "NewsTypeScrollBarButtonDelegate.h"

#import "BNSNewsTableView.h"

//layout
#define HEIGHT_NEWSTYPEBAR 30
#define GAP_LEN ( (CGRectGetWidth(self.view.bounds)) / 9.f )

@interface BNSNewsViewController () <UIScrollViewDelegate, BNSNewsTypeScrollBarButtonDelegate>

@property (retain, nonatomic) NSMutableArray *newsTypeArray;
@property (retain, nonatomic) NSMutableArray *newsAddressArray;

//顶部轮播图
@property (retain, nonatomic) BNSNewsTypeScrollBar *newsTypeBar;
//底部轮播图
@property (retain, nonatomic) OrderView *orderView;
@end

@implementation BNSNewsViewController

#pragma mark - NewsViewController Lifecycle

- (void)dealloc {
	
	[_newsTypeArray release];
	[_newsAddressArray release];
	[_newsTypeBar release];
	[_orderView release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//关闭ViewController的自动调整scrollView功能
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[self loadData];
	[self loadUI];
	
}

- (void)loadData {
	
	/**
	 *  新闻类型
	 */
	self.newsTypeArray = [NSMutableArray array];
	[_newsTypeArray addObject:@"科技"];
	[_newsTypeArray addObject:@"娱乐"];
	[_newsTypeArray addObject:@"体育"];
	[_newsTypeArray addObject:@"游戏"];
	[_newsTypeArray addObject:@"政务"];
	[_newsTypeArray addObject:@"历史"];
	
	
	/**
	 *  新闻地址
	 */
	self.newsAddressArray = [NSMutableArray array];
	//科技
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348649580692/0-20.html"];
	//娱乐
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html"];
	//体育
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348649079062/0-20.html"];
	//游戏
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348654151579/0-20.html"];
	//政务
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1414142214384/0-20.html"];

	
}

#pragma mark - Layout 

- (void)loadUI {
	
	CGFloat width = CGRectGetWidth(self.view.bounds);
	CGFloat height = CGRectGetHeight(self.view.bounds);
	
	//顶部的新闻类型选项栏
	self.newsTypeBar = [[[BNSNewsTypeScrollBar alloc] initWithFrame:CGRectMake(0, 64, width, HEIGHT_NEWSTYPEBAR)] autorelease];
	_newsTypeBar.scrollBarButtonDelegate = self;
	_newsTypeBar.datas = _newsTypeArray;
	_newsTypeBar.contentSize = CGSizeMake(width + 4 * GAP_LEN, HEIGHT_NEWSTYPEBAR);
	_newsTypeBar.contentOffset = CGPointMake(2 * GAP_LEN, 0);

	//底部的转动视图
	CGFloat contentScrollViewX = 0;
	CGFloat contentScrollViewY = 64 + HEIGHT_NEWSTYPEBAR;
	CGFloat contentScrollViewWidth = width;
	CGFloat tabBarHeight = [[NSUserDefaults standardUserDefaults] floatForKey:@"tabBarHeight"];
	CGFloat contentScrollViewHeight = height - 64 - HEIGHT_NEWSTYPEBAR - tabBarHeight;
	
	CGRect contentScrollViewFrame = CGRectMake(contentScrollViewX,
											   contentScrollViewY,
											   contentScrollViewWidth,
											   contentScrollViewHeight);
	self.orderView = [[[OrderView alloc] initWithFrame:contentScrollViewFrame] autorelease];
	_orderView.datas = _newsAddressArray;
	[_orderView configureScrollViewAtIndex:0
									 count:_newsAddressArray.count
								   options:OrderDirectionTypeNone];
	
	[self.view addSubview:_orderView];
	[self.view addSubview:_newsTypeBar];
	
	[_orderView setNeedsLayout];
	[_orderView layoutIfNeeded];
	_orderView.scrollView.contentOffset = CGPointMake(contentScrollViewWidth, 0);
}


#pragma mark - BNSNewsTypeScrollBarButtonDelegate

- (void)scrollBarButtonDidSelect:(BNSNewsTypeScrollBarButton *)button {
#warning - add actions
	NSLog(@"jump");
}


@end
