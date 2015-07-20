//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBar.h"

#define GAP ( (CGRectGetWidth(self.bounds)) / 9.f )

@interface BNSNewsTypeScrollBar ()

@property (assign, nonatomic) NSInteger top;
@property (assign, nonatomic) CGFloat scrollDistance;
@property (retain, nonatomic) BNSNewsButton *contentButton;
@end

@implementation BNSNewsTypeScrollBar

#pragma mark - NewsTypeScrollBar Lifecycle

- (void)dealloc {
    
    [_contentButton release];
    [_datas release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.delegate = self;
		self.bounces = NO;
		self.pagingEnabled = YES;
		self.directionalLockEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
		
		_contentButton = [[BNSNewsButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width + 4 * GAP, 30)];
		self.contentButton.frame = CGRectMake(0, 0, self.bounds.size.width + 4 * GAP, 30);
		_contentButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_contentButton];
		
		self.top = 0;
	}
	return self;
}

#pragma mark - Layout 

- (void)layoutSubviews {
	[super layoutSubviews];
	self.contentButton.frame = CGRectMake(0, 0, self.bounds.size.width + 4 * GAP, 30);
}

#pragma mark - setter

- (void)setScrollBarButtonDelegate:(id)delegate {
	
	_contentButton.entertainmentButton.buttonDelegate = delegate;
	_contentButton.sportsButton.buttonDelegate = delegate;
	_contentButton.gamesButton.buttonDelegate = delegate;
	_contentButton.politicsButton.buttonDelegate = delegate;
}

#pragma mark - private method

- (void)configureScrollViewAtIndex:(NSUInteger)index
							 count:(NSUInteger)count
						   options:(OrderDirectionType)options {
    
    NSUInteger firstIndex = index % count;
    NSUInteger secondIndex = (index + 1) % count;
    NSUInteger thirdIndex = (index + 2) % count;
    NSUInteger fourthIndex = (index + 3) % count;
    NSUInteger fifthIndex = (index + 4) % count;
    NSUInteger sixthIndex = (index + 5) % count;
    
    [_contentButton.technologyButton setTitle:_datas[firstIndex] forState:UIControlStateNormal];
    [_contentButton.entertainmentButton setTitle:_datas[secondIndex] forState:UIControlStateNormal];
    [_contentButton.sportsButton setTitle:_datas[thirdIndex] forState:UIControlStateNormal];
    [_contentButton.gamesButton setTitle:_datas[fourthIndex] forState:UIControlStateNormal];
    [_contentButton.politicsButton setTitle:_datas[fifthIndex] forState:UIControlStateNormal];
    [_contentButton.historyButton setTitle:_datas[sixthIndex] forState:UIControlStateNormal];
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//	
//	NSUInteger count = _datas.count;
//	OrderDirectionType type = 0;
//	if (self.scrollDistance > 10) {
//		
//		_top = _top + 1;
//		if (_top >= count) {
//			_top = 0;
//		}
//		type = OrderDirectionTypeLeft;
//	}else if (self.scrollDistance < -10) {
//		
//		_top = _top - 1;
//		if (_top < 0) {
//			_top = count - 1;
//		}
//		type = OrderDirectionTypeRight;
//	}
//    
//    [self configureScrollViewAtIndex:_top count:_datas.count options:type];
//	self.contentOffset = CGPointMake(2 * GAP, 0);
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

//	BOOL buttonSelected = [[NSUserDefaults standardUserDefaults] boolForKey:@"ButtonSelect"];
//	if (buttonSelected) {
//		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ButtonSelect"];
//		return;
//	}
	NSUInteger count = _datas.count;
	OrderDirectionType type = 0;
	CGFloat offsetX = self.contentOffset.x;
	NSLog(@"%f", offsetX);
	if (offsetX > 2 * GAP) {
		
		_top = _top + 1;
		if (_top >= count) {
			_top = 0;
		}
		type = OrderDirectionTypeLeft;
	}else if (offsetX < 2 * GAP) {
		
		_top = _top - 1;
		if (_top < 0) {
			_top = count - 1;
		}
		type = OrderDirectionTypeRight;
	}
	
	self.contentOffset = CGPointMake(2 * GAP, 0);
	[self configureScrollViewAtIndex:_top count:_datas.count options:type];
	

}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//	
//    self.scrollDistance = targetContentOffset->x - 2 * GAP;
//}

@end
