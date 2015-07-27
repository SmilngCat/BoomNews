//
//  LunBoView.m
//  LunBo
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSView.h"
#import "BNSScrollView.h"
#import "BNSScrollContentView.h"

#import "UIImageView+WebCache.h"

@interface BNSView () <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger top;
@end

@implementation BNSView

#pragma mark - LunBoView Lifecycle

- (void)dealloc {
	[_images release];
	[_scrollView release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_scrollView = [[BNSScrollView alloc] init];
		_scrollView.delegate = self;
		_scrollView.bounces = NO;
		_scrollView.pagingEnabled = YES;
		_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_scrollView];
		
		[self buildLayout];
		
		//_scrollView.backgroundColor = [UIColor blueColor];
		_top = 0;
	}
	return self;
}

#pragma mark - Layout

- (void)buildLayout {
	UIView *view = self;
	BNSScrollContentView *contentView = _scrollView.contentView;
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

- (void)scrollViewDidEndDecelerating:(BNSScrollView *)scrollView {
    
    if (self.bnsScrollDelegate && [self.bnsScrollDelegate respondsToSelector:@selector(changeIndex)]) {
        [self.bnsScrollDelegate changeIndex];
    }
	
	CGFloat width =  CGRectGetWidth(self.bounds);
	NSUInteger count = _images.count;
	
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
	[self bns_ConfigureScrollViewAtIndex:_top count:count];
	
	scrollView.contentOffset = CGPointMake(width, 0);
}

- (void)bns_ConfigureScrollViewAtIndex:(NSUInteger)index count:(NSUInteger)count {
	
    [_scrollView.contentView.leftImageView sd_setImageWithURL:[NSURL URLWithString:_images[index % count]]];
    [_scrollView.contentView.middleImageView sd_setImageWithURL:[NSURL URLWithString:_images[(index + 1) % count]]];
    [_scrollView.contentView.rightImageView sd_setImageWithURL:[NSURL URLWithString:_images[(index + 2) % count]]];


}

- (NSString *)description {
	return NSStringFromCGSize(_scrollView.contentSize);
}



@end
