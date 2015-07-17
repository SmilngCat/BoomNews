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
		
		_top = 1;
	}
	return self;
}

#pragma mark - Layout

- (void)layoutSubviews {
	[super layoutSubviews];
	
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
	
	if (scrollView.contentOffset.x == 2*width) {
		
		_top = _top + 1;
		if (_top >= count) {
			_top = 0;
		}
		
	}else if (scrollView.contentOffset.x == 0) {
		
		_top = _top - 1;
		if (_top < 0) {
			_top = count - 1;
		}
	}
	[self configureScrollViewAtIndex:_top count:count];
	
	scrollView.contentOffset = CGPointMake(width, 0);
}

- (void)configureScrollViewAtIndex:(NSUInteger)index count:(NSUInteger)count {
	
	NSUInteger leftIndex = index % count;
	NSUInteger middleIndex = (index + 1) % count;
	NSUInteger rightIndex = (index + 2) % count;
	
	NSString *leftString = _datas[leftIndex];
	NSString *middleString = _datas[middleIndex];
	NSString *rightString = _datas[rightIndex];
	
	[_scrollView.contentView.leftView setUrlString:leftString];
	[_scrollView.contentView.leftView loadData:leftIndex];
	
	[_scrollView.contentView.middleView setUrlString:middleString];
	[_scrollView.contentView.middleView loadData:middleIndex];
	
	[_scrollView.contentView.rightView setUrlString:rightString];
	[_scrollView.contentView.rightView loadData:rightIndex];
}

- (NSString *)description {
	return NSStringFromCGSize(_scrollView.contentSize);
}


@end
