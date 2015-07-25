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



@interface BNSNewsViewController () <UIScrollViewDelegate, OrderViewDelegate, BNSNewsTypeScrollBarButtonDelegate>

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
	
	[_navigationBarImages release];
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
	
	//设置轮播当前显示哪一个类型的数据
	[[NSUserDefaults standardUserDefaults] setInteger:1 forMutableKey:@"Index"];
	
	[self loadData];
	[self loadUI];
	
}

- (void)loadData {
	
	NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"BNSResource" ofType:@"plist"];
	NSArray *resourceArray = [NSArray arrayWithContentsOfFile:resourcePath];
	NSArray *navigationBarImagesArr = resourceArray[0];
	NSArray *newsTypeArr = resourceArray[1];
	NSArray *newsAddressArr = resourceArray[2];
	
 /**
  *  navigationBarImages
  */
	self.navigationBarImages = [NSMutableArray array];
	[navigationBarImagesArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger index, BOOL *stop) {
		[_navigationBarImages addObject:obj];
	}];
	
//	[_navigationBarImages addObject:[UIImage imageNamed:@"technoligy"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"entermentain"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"sports"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"game"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"policy"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"history"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"finance"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"military"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"lottory"]];
//	[_navigationBarImages addObject:[UIImage imageNamed:@"fashion"]];
	
	/**
	 *  新闻类型
	 */
	self.newsTypeArray = [NSMutableArray array];
	[newsTypeArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger index, BOOL *stop) {
		[_newsTypeArray addObject:obj];
	}];
//	[_newsTypeArray addObject:@"科技"];
//	[_newsTypeArray addObject:@"娱乐"];
//	[_newsTypeArray addObject:@"体育"];
//	[_newsTypeArray addObject:@"游戏"];
//	[_newsTypeArray addObject:@"政务"];
//	[_newsTypeArray addObject:@"历史"];
//	[_newsTypeArray addObject:@"财经"];
//	[_newsTypeArray addObject:@"军事"];
//	[_newsTypeArray addObject:@"彩票"];
//	[_newsTypeArray addObject:@"时尚"];
	
	/**
	 *  新闻地址
	 */
	self.newsAddressArray = [NSMutableArray array];
	[newsAddressArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger index, BOOL *stop) {
		[_newsAddressArray addObject:obj];
	}];
//	//科技
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348649580692/20-40.html"];
//	//娱乐
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648517839"];
//	//体育
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348649079062"];
//	//游戏
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348654151579"];
//	//政务
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1414142214384"];
//	//历史
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1368497029546"];
//	//财经
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648756099"];
//	//军事
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348648141035"];
//	//彩票
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1356600029035"];
//	//时尚
//	[_newsAddressArray addObject:@"http://c.m.163.com/nc/article/list/T1348650593803"];

}

#pragma mark - Layout 

- (void)loadUI {
	
	CGFloat width = CGRectGetWidth(self.view.bounds);
	CGFloat height = CGRectGetHeight(self.view.bounds);
	
	CGFloat gap_Len = (CGRectGetWidth(self.view.bounds) - 4 * WIDTH_NEWSTYPEBAR) / 5.f;
	CGFloat part_Len = gap_Len + WIDTH_NEWSTYPEBAR;
	//顶部的新闻类型选项栏
	self.newsTypeBar = [[[BNSNewsTypeScrollBar alloc] initWithFrame:CGRectMake(0, 64, width, HEIGHT_NEWSTYPEBAR)] autorelease];
	_newsTypeBar.scrollBarButtonDelegate = self;
	_newsTypeBar.datas = _newsTypeArray;
	_newsTypeBar.contentSize = CGSizeMake(7 * gap_Len + 6 * WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
	_newsTypeBar.contentOffset = CGPointMake(part_Len, 0);

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
	_orderView.delegate = self;
	[_orderView configureScrollViewAtIndex:0
									 count:_newsAddressArray.count
								   options:OrderDirectionTypeNone];
	
	[self.view addSubview:_orderView];
	[self.view addSubview:_newsTypeBar];
	
	[_orderView setNeedsLayout];
	[_orderView layoutIfNeeded];
	_orderView.scrollView.contentOffset = CGPointMake(contentScrollViewWidth, 0);
}


#pragma mark - OrderViewDelegate

- (void)orderView:(OrderView *)oredrView didScrollToIndex:(NSUInteger)index options:(OrderDirectionType)options{
	
	[_newsTypeBar configureScrollViewAtIndex:index
									   count:_newsTypeArray.count
									 options:options];
}


#pragma mark - BNSNewsTypeScrollBarButtonDelegate

- (void)scrollBarButtonDidSelect:(BNSNewsTypeScrollBarButton *)button {

	NSString *title = button.titleLabel.text;
	NSUInteger index = [self indexOfString:title inArray:_newsTypeArray];
	
	[_newsTypeBar configureScrollViewAtIndex:index - 1
									   count:_newsTypeArray.count
									 options:OrderDirectionTypeNone];
	
	//上下轮播图互动
	[[NSUserDefaults standardUserDefaults] setInteger:index forMutableKey:@"Index"];
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
