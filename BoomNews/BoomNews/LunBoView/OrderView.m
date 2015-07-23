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
//	NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//	[middleView scrollToRowAtIndexPath:scrollIndexPath
//					  atScrollPosition:UITableViewScrollPositionTop
//							  animated:YES];
	
	leftView.invalidate = YES;
	middleView.invalidate = YES;
	rightView.invalidate = YES;
}


- (void)setViewController:(UIViewController *)viewController {
    _scrollView.contentView.leftView.viewController = viewController;
    _scrollView.contentView.middleView.viewController = viewController;
    _scrollView.contentView.rightView.viewController = viewController;
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
//			[leftView bns_LoadData:leftIndex];
//			[middleView bns_LoadData:middleIndex];
//			[rightView bns_LoadData:rightIndex];
			[leftView headerBeginRefreshing];
			[middleView headerBeginRefreshing];
			[rightView headerBeginRefreshing];
			break;
		}
		case OrderDirectionTypeLeft: {
//			leftView.datas = middleView.datas;
//			middleView.datas = rightView.datas;
			[leftView.datas depthCopyWithMutableArray:middleView.datas];
			[middleView.datas depthCopyWithMutableArray:rightView.datas];
			[leftView reloadData];
			[middleView reloadData];
//			[rightView bns_LoadData:rightIndex];
			[rightView headerBeginRefreshing];
			break;
		}
		case OrderDirectionTypeRight: {
//			rightView.datas = middleView.datas;
//			middleView.datas = leftView.datas;
			[rightView.datas depthCopyWithMutableArray:middleView.datas];
			[middleView.datas depthCopyWithMutableArray:leftView.datas];
			[middleView reloadData];
			[rightView reloadData];
//			[leftView bns_LoadData:leftIndex];
			[leftView headerBeginRefreshing];
			break;
		}
	}

}

- (NSString *)description {
	return NSStringFromCGSize(_scrollView.contentSize);
}


@end
