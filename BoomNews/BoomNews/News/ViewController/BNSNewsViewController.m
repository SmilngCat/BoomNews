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
#define WIDTH_NEWSTYPEBAR 50
#define HEIGHT_NEWSTYPEBAR 30

#define GAP_LEN ( (CGRectGetWidth(self.view.bounds) - 4 * WIDTH_NEWSTYPEBAR) / 5.f )
#define PART_LEN (WIDTH_NEWSTYPEBAR + GAP_LEN)

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
	[_newsTypeArray addObject:@"财经"];
	[_newsTypeArray addObject:@"军事"];
	[_newsTypeArray addObject:@"彩票"];
	[_newsTypeArray addObject:@"时尚"];
	
	/**
	 *  新闻地址
	 */
	self.newsAddressArray = [NSMutableArray array];
	//科技
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348649580692"];
	//娱乐
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648517839"];
	//体育
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348649079062"];
	//游戏
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348654151579"];
	//政务
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1414142214384"];
	//历史
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1368497029546"];
	//财经
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648756099"];
	//军事
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648141035"];
	//彩票
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1356600029035"];
	//时尚
	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348650593803"];

}

#pragma mark - Layout 

- (void)loadUI {
	
	CGFloat width = CGRectGetWidth(self.view.bounds);
	CGFloat height = CGRectGetHeight(self.view.bounds);
	
	//顶部的新闻类型选项栏
	self.newsTypeBar = [[[BNSNewsTypeScrollBar alloc] initWithFrame:CGRectMake(0, 64, width, HEIGHT_NEWSTYPEBAR)] autorelease];
	_newsTypeBar.scrollBarButtonDelegate = self;
	_newsTypeBar.datas = _newsTypeArray;
	_newsTypeBar.contentSize = CGSizeMake(width + 2 * PART_LEN, HEIGHT_NEWSTYPEBAR);
	_newsTypeBar.contentOffset = CGPointMake(PART_LEN, 0);

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
    _orderView.viewController = self;
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

	NSString *title = button.titleLabel.text;
	NSUInteger index = [self indexOfString:title inArray:_newsTypeArray];
	[self.orderView scrollViewDidEndScrollAtIndex:index - 1
											count:_newsTypeArray.count
										  options:OrderDirectionTypeNone];
}

/**
 *  根据标题名找到其数组下标
 *
 *  @param title 标题名
 *  @param array 数组
 *
 *  @return 数组下标
 */
- (NSUInteger)indexOfString:(NSString *)title inArray:(NSArray *)array {
	
	__block NSUInteger idx = 0;
	[array enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
		if ([title isEqualToString:obj]) {
			idx = index;
			*stop = YES;
		}
	}];
	return idx;
}

@end
