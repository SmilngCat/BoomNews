//
//  NewsTypeScrollBar.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsTypeScrollBar.h"
#import "BNSNewsButton.h"


@interface BNSNewsTypeScrollBar ()

@property (assign, nonatomic) NSInteger top;
@property (assign, nonatomic) CGFloat scrollDistance;
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
		self.bounces = NO;
		self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.contentButton];
        self.delegate = self;

	}
	return self;
}

#pragma mark - Layout 

- (void)layoutSubviews {
	[super layoutSubviews];
	//CGRectGetWidth(self.bounds) / 9.f
    CGFloat width = CGRectGetWidth(self.frame);
    self.contentButton.frame = CGRectMake(0, 0, self.bounds.size.width + 4 * (width / 9), 30);

    self.contentButton.politicsButton.frame = CGRectMake(width / 9, 0, width / 9, 30);
    self.contentButton.entertainmentButton.frame = CGRectMake(3 * (width / 9), 0, width / 9, 30);
    self.contentButton.sportsButton.frame = CGRectMake(5 * (width / 9), 0, width / 9, 30);
    self.contentButton.gamesButton.frame = CGRectMake(7 * (width / 9) , 0, width / 9, 30);
    self.contentButton.historyButton.frame = CGRectMake(9 * (width / 9), 0, width / 9, 30);
    self.contentButton.technologyButton.frame = CGRectMake(11 * (width / 9), 0, width / 9, 30);

}

#pragma mark - Lazy loading



- (BNSNewsButton *)contentButton {

    if (!_contentButton) {
        _contentButton = [[BNSNewsButton alloc] init];
        _contentButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentButton;
}

- (void)configureScrollViewAtIndex:(NSUInteger)index
							 count:(NSUInteger)count
						   options:(OrderDirectionType)options {
    
    NSUInteger firstIndex = index % count;
    NSUInteger secondIndex = (index + 1) % count;
    NSUInteger thirdIndex = (index + 2) % count;
    NSUInteger fourthIndex = (index + 3) % count;
    NSUInteger fifthIndex = (index + 4) % count;
    NSUInteger sixthIndex = (index + 5) % count;
    
    [_contentButton.politicsButton setTitle:_datas[firstIndex] forState:UIControlStateNormal];
    [_contentButton.entertainmentButton setTitle:_datas[secondIndex] forState:UIControlStateNormal];
    [_contentButton.sportsButton setTitle:_datas[thirdIndex] forState:UIControlStateNormal];
    [_contentButton.gamesButton setTitle:_datas[fourthIndex] forState:UIControlStateNormal];
    [_contentButton.historyButton setTitle:_datas[fifthIndex] forState:UIControlStateNormal];
    [_contentButton.technologyButton setTitle:_datas[sixthIndex] forState:UIControlStateNormal];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	NSUInteger count = _datas.count;
	OrderDirectionType type = 0;
	if (self.scrollDistance > 0) {
		
		_top = _top + 1;
		if (_top >= count) {
			_top = 0;
		}
		type = OrderDirectionTypeLeft;
	}else if (self.scrollDistance < 0) {
		
		_top = _top - 1;
		if (_top < 0) {
			_top = count - 1;
		}
		type = OrderDirectionTypeRight;
	}
    
    [self configureScrollViewAtIndex:_top count:_datas.count options:type];
    
	self.contentOffset = CGPointMake(2 * (self.frame.size.width / 9), 0);
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	
    self.scrollDistance = targetContentOffset->x - 2 * (self.frame.size.width / 9);
}

@end
