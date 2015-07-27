//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBar.h"

#define WIDTH_NEWSTYPEBAR 50
#define HEIGHT_NEWSTYPEBAR 30


@interface BNSNewsTypeScrollBar ()

@property (assign, nonatomic) NSInteger top;
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
//		self.pagingEnabled = YES;
		self.directionalLockEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
		
		CGFloat width = CGRectGetWidth(frame);
		CGFloat gap_Len = (width - 4 * WIDTH_NEWSTYPEBAR) / 5.f;
		_contentButton = [[BNSNewsButton alloc] initWithFrame:CGRectMake(0, 0, 7 * gap_Len + 6 * WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR)];
        [self addSubview:_contentButton];

		_top = 0;
	}
	return self;
}

#pragma mark - Layout 

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat gap_Len = (width - 4 * WIDTH_NEWSTYPEBAR) / 5.f;
	_contentButton.frame = CGRectMake(0, 0, 7 * gap_Len + 6 * WIDTH_NEWSTYPEBAR, HEIGHT_NEWSTYPEBAR);
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
	
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat gap_Len = (width - 4 * WIDTH_NEWSTYPEBAR) / 5.f;
	CGFloat part_Len = gap_Len + WIDTH_NEWSTYPEBAR;
    self.contentOffset = CGPointMake(part_Len, 0);
	
    NSUInteger firstIndex = index % count;
    NSUInteger secondIndex = (index + 1) % count;
    NSUInteger thirdIndex = (index + 2) % count;
    NSUInteger fourthIndex = (index + 3) % count;
    NSUInteger fifthIndex = (index + 4) % count;
    NSUInteger sixthIndex = (index + 5) % count;
	
	NSString *firstTitle = _datas[firstIndex];
	NSString *secondTitle = _datas[secondIndex];
	NSString *thirdTitle = _datas[thirdIndex];
	NSString *fourthTitle = _datas[fourthIndex];
	NSString *fifthTitle = _datas[fifthIndex];
	NSString *sixthTitle = _datas[sixthIndex];
    
    [_contentButton.technologyButton setTitle:firstTitle
									 forState:UIControlStateNormal];
	[_contentButton.technologyButton setTitleColor:[UIColor blackColor]
										  forState:UIControlStateNormal];
	_contentButton.technologyButton.index = firstIndex;
	
    [_contentButton.entertainmentButton setTitle:secondTitle
										forState:UIControlStateNormal];
	[_contentButton.entertainmentButton setTitleColor:[UIColor blackColor]
										  forState:UIControlStateNormal];
	_contentButton.entertainmentButton.index = secondIndex;
	
    [_contentButton.sportsButton setTitle:thirdTitle
								 forState:UIControlStateNormal];
	[_contentButton.sportsButton setTitleColor:[UIColor blackColor]
										  forState:UIControlStateNormal];
	_contentButton.sportsButton.index = thirdIndex;
	
    [_contentButton.gamesButton setTitle:fourthTitle
								forState:UIControlStateNormal];
	[_contentButton.gamesButton setTitleColor:[UIColor blackColor]
									  forState:UIControlStateNormal];
	_contentButton.gamesButton.index = fourthIndex;
	
    [_contentButton.politicsButton setTitle:fifthTitle
								   forState:UIControlStateNormal];
	[_contentButton.politicsButton setTitleColor:[UIColor blackColor]
									 forState:UIControlStateNormal];
	_contentButton.politicsButton.index = fifthIndex;
	
    [_contentButton.historyButton setTitle:sixthTitle
								  forState:UIControlStateNormal];
	[_contentButton.historyButton setTitleColor:[UIColor blackColor]
									 forState:UIControlStateNormal];
	_contentButton.historyButton.index = sixthIndex;
	
	//通知类型更改 
	[[NSNotificationCenter defaultCenter] postNotificationName:kBNSIndexChanged object:nil];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat gap_Len = (width - 4 * WIDTH_NEWSTYPEBAR) / 5.f;
	CGFloat part_Len = gap_Len + WIDTH_NEWSTYPEBAR;
	
	NSUInteger count = _datas.count;
	OrderDirectionType type = 0;
	CGFloat offsetX = self.contentOffset.x;
	
	if (offsetX > part_Len) {
		
		_top = _top + 1;
		if (_top >= count) {
			_top = 0;
		}
		type = OrderDirectionTypeLeft;
		
	}else if (offsetX < part_Len) {
		
		_top = _top - 1;
		if (_top < 0) {
			_top = count - 1;
		}
		type = OrderDirectionTypeRight;
	}
	
	[self configureScrollViewAtIndex:_top count:_datas.count options:type];
	
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	CGFloat width = CGRectGetWidth(self.bounds);
	CGFloat gap_Len = (width - 4 * WIDTH_NEWSTYPEBAR) / 5.f;
	CGFloat part_Len = gap_Len + WIDTH_NEWSTYPEBAR;
	self.contentOffset = CGPointMake(part_Len, 0);
	
}

@end
