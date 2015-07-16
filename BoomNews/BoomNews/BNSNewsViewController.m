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

#import "BNSNewsEntertainmentTableView.h"

//layout
#define HEIGHT_NEWSTYPEBAR 30

@interface BNSNewsViewController () <UIScrollViewDelegate, BNSNewsTypeScrollBarButtonDelegate>

@property (retain, nonatomic) BNSNewsTypeScrollBarContentView *newsTypeBar;
@property (retain, nonatomic) UIScrollView *contentScrollView;
@end

@implementation BNSNewsViewController

#pragma mark - NewsViewController Lifecycle

- (void)dealloc {
	
	[_newsTypeBar release];
	[_contentScrollView release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//关闭ViewController的自动调整scrollView功能
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[self loadUI];
	
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
	self.contentScrollView = [[[UIScrollView alloc] initWithFrame:contentScrollViewFrame] autorelease];
	_contentScrollView.delegate = self;
	_contentScrollView.bounces = NO;
	_contentScrollView.pagingEnabled = YES;
	_contentScrollView.directionalLockEnabled = YES;
	_contentScrollView.showsHorizontalScrollIndicator = NO;
	_contentScrollView.showsVerticalScrollIndicator = NO;
	_contentScrollView.contentSize = CGSizeMake(4 * contentScrollViewWidth, contentScrollViewHeight);
	
	[self.view addSubview:_contentScrollView];
	[self.view addSubview:_newsTypeBar];
	
	//给scrollView添加tableView
	[self loadScrollContentViewWithWidth:contentScrollViewWidth height:contentScrollViewHeight];
	
}

- (void)loadScrollContentViewWithWidth:(CGFloat)width height:(CGFloat)height{
	CGRect rect = CGRectMake(0, 0, width, height);
	BNSNewsEntertainmentTableView *entertainmentTableView = [[BNSNewsEntertainmentTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
	[_contentScrollView addSubview:entertainmentTableView];
	
	[entertainmentTableView release];
}

#pragma mark - BNSNewsTypeScrollBarButtonDelegate

- (void)scrollBarButtonDidSelect:(BNSNewsTypeScrollBarButton *)button {
#warning - add actions
	NSLog(@"jump");
}

@end
