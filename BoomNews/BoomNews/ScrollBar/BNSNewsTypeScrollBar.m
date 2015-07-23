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

#define GAP_LEN ( (CGRectGetWidth(self.bounds) - 4 * WIDTH_NEWSTYPEBAR) / 5.f )
#define PART_LEN (WIDTH_NEWSTYPEBAR + GAP_LEN)

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
		self.pagingEnabled = YES;
		self.directionalLockEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
		
		_contentButton = [[BNSNewsButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width + 2 * PART_LEN, 30)];
		_contentButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_contentButton];
		
		self.top = 0;
	}
	return self;
}

#pragma mark - Layout 

- (void)layoutSubviews {
	[super layoutSubviews];
	self.contentButton.frame = CGRectMake(0, 0, self.bounds.size.width + 2 * PART_LEN, 30);
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

	NSUInteger count = _datas.count;
	OrderDirectionType type = 0;
	CGFloat offsetX = self.contentOffset.x;
	
	if (offsetX > PART_LEN) {
		
		_top = _top + 1;
		if (_top >= count) {
			_top = 0;
		}
		type = OrderDirectionTypeLeft;
		
	}else if (offsetX < PART_LEN) {
		
		_top = _top - 1;
		if (_top < 0) {
			_top = count - 1;
		}
		type = OrderDirectionTypeRight;
	}
	
	self.contentOffset = CGPointMake(PART_LEN, 0);
	[self configureScrollViewAtIndex:_top count:_datas.count options:type];
	
}


@end
