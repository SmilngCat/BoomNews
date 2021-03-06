//
//  LunBoView.m
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "OrderView.h"
#import "OrderScrollView.h"
#import "OrderScrollContentView.h"

#import "NSMutableArray+DepthCopy.h"
#import "BNSNewsViewController.h"


@interface OrderView () <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger top;
@end

@implementation OrderView

#pragma mark - LunBoView Lifecycle

- (void)dealloc {
	[_datas release];
	[_scrollView release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_scrollView = [[OrderScrollView alloc] init];
		_scrollView.delegate = self;
		_scrollView.bounces = NO;
		_scrollView.pagingEnabled = YES;
		_scrollView.directionalLockEnabled = YES;
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_scrollView];
		
		[self buildLayout];
		_top = 0;
	}
	return self;
}

#pragma mark - Setter

- (void)setViewController:(UIViewController *)viewController {
	_scrollView.contentView.leftView.viewController = viewController;
	_scrollView.contentView.middleView.viewController = viewController;
	_scrollView.contentView.rightView.viewController = viewController;
}


#pragma mark - Layout

- (void)buildLayout {
	
	UIView *view = self;
	OrderScrollContentView *contentView = _scrollView.contentView;
	NSDictionary *views = NSDictionaryOfVariableBindings(view, _scrollView, contentView);
	
	//scrollView
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
																 options:0
																 metrics:0
																   views:views]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
																 options:0
																 metrics:0
																   views:views]];
	//contentView
	[self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
													 attribute:NSLayoutAttributeWidth
													 relatedBy:NSLayoutRelationEqual
														toItem:self
													 attribute:NSLayoutAttributeWidth
													multiplier:3.f constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:contentView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:self
													 attribute:NSLayoutAttributeHeight
													multiplier:1.f constant:0]];

}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(OrderScrollView *)scrollView {
	
	CGFloat width =  CGRectGetWidth(self.bounds);
	NSUInteger count = _datas.count;
	
	OrderDirectionType directionType = 0;
	//向左滑动
	if (scrollView.contentOffset.x == 2*width) {
		
		_top = _top + 1;
		if (_top >= count) {
			_top = 0;
		}
		directionType = OrderDirectionTypeLeft;
	//向右滑动
	}else if (scrollView.contentOffset.x == 0) {
		
		_top = _top - 1;
		if (_top < 0) {
			_top = count - 1;
		}
		directionType = OrderDirectionTypeRight;
	}
	[self scrollViewDidEndScrollAtIndex:_top count:count options:directionType];
	
	//上下的轮播图互动
	[[NSUserDefaults standardUserDefaults] setInteger:_top forMutableKey:@"Index"];
	if (self.delegate && [self.delegate respondsToSelector:@selector(orderView:didScrollToIndex:options:)]) {
		//当前选中的新闻类型
		[[NSUserDefaults standardUserDefaults] setInteger:(_top + 1) % count forMutableKey:@"Index"];
		[self.delegate orderView:self didScrollToIndex:_top options:directionType];
	}
}


- (void)scrollViewDidEndScrollAtIndex:(NSUInteger)index
								count:(NSUInteger)count
							  options:(OrderDirectionType)options {
	
	CGFloat width =  CGRectGetWidth(self.bounds);
	_scrollView.contentOffset = CGPointMake(width, 0);
	
	[self configureScrollViewAtIndex:index count:count options:options];
	
	ContentView *leftView = (ContentView *)_scrollView.contentView.leftView;
	ContentView *middleView = (ContentView *)_scrollView.contentView.middleView;
	ContentView *rightView = (ContentView *)_scrollView.contentView.rightView;
	
	//加载数据的偏移量清零
	leftView.offset = 0;
	middleView.offset = 0;
	rightView.offset = 0;
	
	//清空缓存
	leftView.invalidate = YES;
	middleView.invalidate = YES;
	rightView.invalidate = YES;
}



- (void)configureScrollViewAtIndex:(NSUInteger)index
							 count:(NSUInteger)count
						   options:(OrderDirectionType)options{
	
	
	NSUInteger leftIndex = index % count;
	NSUInteger middleIndex = (index + 1) % count;
	NSUInteger rightIndex = (index + 2) % count;
	
	NSString *leftString = _datas[leftIndex];
	NSString *middleString = _datas[middleIndex];
	NSString *rightString = _datas[rightIndex];
	
	ContentView *leftView = (ContentView *)_scrollView.contentView.leftView;
	ContentView *middleView = (ContentView *)_scrollView.contentView.middleView;
	ContentView *rightView = (ContentView *)_scrollView.contentView.rightView;
	
	//给对应的BNSNewsTableView传urlString
	[leftView setUrlString:leftString];
	[middleView setUrlString:middleString];
	[rightView setUrlString:rightString];
	
	/**
	 *  中间的BNSNewsTableView需要做特殊处理，如果是第一次出现则加载数据；
	 *	如果是左滑或则右滑的话，则将左右的请求数据赋给它。
	 */
	switch (options) {
		case OrderDirectionTypeNone: {
			//下拉刷新
			[leftView headerBeginRefreshing];
			[middleView headerBeginRefreshing];
			[rightView headerBeginRefreshing];
			break;
		}
		case OrderDirectionTypeLeft: {
			//更新左边数据
			[leftView.datas removeAllObjects];
			[leftView.cache1 removeAllObjects];
			[leftView reloadData];
			[leftView.datas depthCopyWithMutableArray:middleView.datas];
			[leftView.cache1 depthCopyWithMutableArray:middleView.cache1];
			[leftView reloadData];
			
			//更新中间数据
			[middleView.datas removeAllObjects];
			[middleView.cache1 removeAllObjects];
			[middleView reloadData];
			[middleView.datas depthCopyWithMutableArray:rightView.datas];
			[middleView.cache1 depthCopyWithMutableArray:rightView.cache1];
			[middleView reloadData];

			//下拉刷新
			[rightView headerBeginRefreshing];
			break;
		}
		case OrderDirectionTypeRight: {
			//更新右边数据
			[rightView.datas removeAllObjects];
			[rightView.cache1 removeAllObjects];
			[rightView reloadData];
			[rightView.datas depthCopyWithMutableArray:middleView.datas];
			[rightView.cache1 depthCopyWithMutableArray:middleView.cache1];
			[rightView reloadData];
			
			//更新中间数据
			[middleView.datas removeAllObjects];
			[middleView.cache1 removeAllObjects];
			[middleView reloadData];
			[middleView.datas depthCopyWithMutableArray:leftView.datas];
			[middleView.cache1 depthCopyWithMutableArray:leftView.cache1];
			[middleView reloadData];

			//下拉刷新
			[leftView headerBeginRefreshing];
			break;
		}
	}

}

- (NSString *)description {
	return NSStringFromCGSize(_scrollView.contentSize);
}


@end
