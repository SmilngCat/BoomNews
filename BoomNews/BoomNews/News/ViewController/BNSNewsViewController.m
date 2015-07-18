//
//  RootViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsViewController.h"
#import "OrderView.h"

#import "BNSNewsTypeScrollBarContentView.h"
#import "NewsTypeScrollBarButtonDelegate.h"

#import "BNSNewsTableView.h"

//layout
#define HEIGHT_NEWSTYPEBAR 30

@interface BNSNewsViewController () <UIScrollViewDelegate, BNSNewsTypeScrollBarButtonDelegate>

@property (retain, nonatomic) NSMutableArray *newsArray;

@property (retain, nonatomic) BNSNewsTypeScrollBarContentView *newsTypeBar;
@property (retain, nonatomic) OrderView *orderView;
@end

@implementation BNSNewsViewController

#pragma mark - NewsViewController Lifecycle

- (void)dealloc {
	
	[_newsArray release];
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
	self.newsArray = [NSMutableArray array];
	//科技
	[_newsArray addObject:@"http://c.m.163.com/nc/article/list/T1348649580692/0-20.html"];
	//娱乐
	[_newsArray addObject:@"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html"];
	//体育
	[_newsArray addObject:@"http://c.m.163.com/nc/article/list/T1348649079062/0-20.html"];
	//游戏
	[_newsArray addObject:@"http://c.m.163.com/nc/article/list/T1348654151579/0-20.html"];
	//政务
	[_newsArray addObject:@"http://c.m.163.com/nc/article/list/T1414142214384/0-20.html"];

}

#pragma mark - Layout 

- (void)loadUI {
	
	CGFloat width = CGRectGetWidth(self.view.bounds);
	CGFloat height = CGRectGetHeight(self.view.bounds);
	//顶部的新闻类型选项栏
	self.newsTypeBar = [[[BNSNewsTypeScrollBarContentView alloc]
						initWithFrame:CGRectMake(0, 64, width, HEIGHT_NEWSTYPEBAR)] autorelease];
	_newsTypeBar.politicsButton.buttonDelegate = self;
	_newsTypeBar.entertainmentButton.buttonDelegate = self;
	_newsTypeBar.sportsButton.buttonDelegate = self;
	_newsTypeBar.gamesButton.buttonDelegate = self;

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
	_orderView.datas = _newsArray;
	[_orderView configureScrollViewAtIndex:0
									 count:_newsArray.count
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
