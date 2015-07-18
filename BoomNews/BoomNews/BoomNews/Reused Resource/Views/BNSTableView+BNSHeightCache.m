//
//  BNSTableView+BNSHeightCache.m
//  BoomNews
//
//  Created by jsix lei on 15/7/17.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView+BNSHeightCache.h"
#import "BNSTableView+BNSTemplateCell.h"

/**
 *  LYDTableViewCellHeightCache类用于缓存cell的高度
 */
@interface BNSCellHeightCache : NSObject

@property (retain, nonatomic) NSMutableArray *caches;//2d array
@end

//缓存高度的缺省值
static CGFloat const kDefaultCellHeightCachedValue = -1;

@implementation BNSCellHeightCache

- (void)dealloc {
	[_caches release];
	[super dealloc];
}

/**
 *  根据各个indexPath创建缓冲区
 *
 *  @param indexPaths indexPath数组
 */
- (void)buildCellHeightCacheAtIndexPaths:(NSArray *)indexPaths {
	if (indexPaths.count == 0) {
		return;
	}
	//create only once
	if (!self.caches) {
		self.caches = [NSMutableArray array];
	}
	
	[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath,
											 NSUInteger index, BOOL *stop) {
		for (int section=0; section<=indexPath.section; ++section) {
			if (section >= _caches.count) {
				_caches[section] = [NSMutableArray array];
			}
		}
		NSMutableArray *rows = _caches[indexPath.section];
		for (int row=0; row<=indexPath.row; ++row) {
			if (row >= rows.count) {
				rows[row] = @(kDefaultCellHeightCachedValue);
			}
		}
	}];
}

/**
 *  判断某一处的高度是否已经缓存
 *
 *  @param indexPath cell的位置
 *
 *  @return YES已经缓存，NO未缓存
 */
- (BOOL)hasCachedCellHeightAtIndexPath:(NSIndexPath *)indexPath {
	
	[self buildCellHeightCacheAtIndexPaths:@[indexPath]];
	NSNumber *height = _caches[indexPath.section][indexPath.row];
	return ![height isEqualToNumber:@(kDefaultCellHeightCachedValue)];
}

/**
 *  获取某一处的高度缓存值
 *
 *  @param indexPath cell的位置
 *
 *  @return cell高度值
 */
- (CGFloat)cachedCellHeightAtIndexPath:(NSIndexPath *)indexPath {
	
	[self buildCellHeightCacheAtIndexPaths:@[indexPath]];
	NSNumber *value = _caches[indexPath.section][indexPath.row];
	CGFloat height = 0;
	
#if CGFLOAT_IS_DOUBLE
	height = value.doubleValue;
#else
	height = value.floatValue;
#endif
	return height;
}

/**
 *  设置某一处的高度缓存值
 *
 *  @param height    设置的高度值
 *  @param indexPath cell的位置
 */
- (void)cacheCellHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath {
	
	[self buildCellHeightCacheAtIndexPaths:@[indexPath]];
	_caches[indexPath.section][indexPath.row] = @(height);
}

@end

@interface BNSTableView (cacheClass)

//缓冲
@property (retain, readonly, nonatomic) BNSCellHeightCache *cache;
//是否开启预缓存
@property (assign, nonatomic) BOOL precacheEnabled;
@end

@implementation BNSTableView (cacheClass)

/**
 *  获得一个缓存类
 *
 */
- (BNSCellHeightCache *)cache {
	BNSCellHeightCache *cache = objc_getAssociatedObject(self, _cmd);
	if (!cache) {
		cache = [[[BNSCellHeightCache alloc] init] autorelease];
		objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN);
	}
	return cache;
}

- (BOOL)precacheEnabled {
	return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPrecacheEnabled:(BOOL)enabled {
	objc_setAssociatedObject(self, @selector(precacheEnabled), @(enabled), OBJC_ASSOCIATION_RETAIN);
}

@end

/**
 *  扩展UITableView,使之支持预缓存
 */
@interface BNSTableView (precache)
@end

@implementation BNSTableView (precache)

/**
 *  获得所有需要缓存的位置
 *
 *  @return 0x7c4525a0
 */
- (NSArray *)allIndexPathsNeededCached {
	NSMutableArray *indexPaths = [NSMutableArray array];
	NSUInteger sections = self.numberOfSections;
	for (NSUInteger section=0; section<sections; ++section) {
		NSUInteger rowsInSection = [self numberOfRowsInSection:section];
		for (NSUInteger row=0; row<rowsInSection; ++row) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			if (![self.cache hasCachedCellHeightAtIndexPath:indexPath]) {
				[indexPaths addObject:indexPath];
			}
		}
	}
	return [indexPaths.copy autorelease];
}

- (void)precacheIfNeeded {
	if (!self.precacheEnabled) {
		return;
	}
	
	if (!self.delegate || ![self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
		return;
	}
	
	//使用当前RunLoop和默认的mode
	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFStringRef runLoopMode = kCFRunLoopDefaultMode;
	NSArray *arr = [self allIndexPathsNeededCached];
	NSMutableArray *indexPaths = [NSMutableArray arrayWithArray:arr];
	
	CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
		
		if (indexPaths.count == 0) {
			CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
			CFRelease(observer);
			return;
		}
		
		NSIndexPath *indexPath = [[indexPaths firstObject] retain];
		[indexPaths removeObject:indexPath];
		[self performSelector:@selector(precacheAtIndexPath:)
					 onThread:[NSThread mainThread]
				   withObject:indexPath
				waitUntilDone:NO
						modes:@[NSDefaultRunLoopMode]];
		[indexPath release];

	});

	
	CFRunLoopAddObserver(runLoop, observer, runLoopMode);
}

- (void)precacheAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section >= self.cache.caches.count ||
		indexPath.row >= [self.cache.caches[indexPath.section] count]) {
		return;
	}
	CGFloat height = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
	[self.cache cacheCellHeight:height atIndexPath:indexPath];
}

@end


@implementation BNSTableView (BNSHeightCache)


- (CGFloat)heightForRowWithIdentifier:(NSString *)identifier
						configuration:(void(^)(id cell))configuration {
	
	if (!identifier) {
		return 0;
	}
	UITableViewCell *cell = [self bns_templateCellWithIdentifier:identifier];
	[cell prepareForReuse];
	if (configuration) {
		configuration(cell);
	}
	CGFloat contentViewWidth = CGRectGetWidth(self.bounds);
	CGSize fittingSize = CGSizeZero;
	if (cell.accessoryView) {
		contentViewWidth -= 10 + CGRectGetWidth(cell.accessoryView.frame);
	}else {
		static CGFloat systemAccessoryViewWidth[] = {
			[UITableViewCellAccessoryNone] = 0,
			[UITableViewCellAccessoryDisclosureIndicator] = 34,
			[UITableViewCellAccessoryDetailDisclosureButton] = 68,
			[UITableViewCellAccessoryCheckmark] = 40,
			[UITableViewCellAccessoryDetailButton] = 48,
		};
		contentViewWidth -= systemAccessoryViewWidth[cell.accessoryType];
	}
	
	BOOL autoLayout = cell.contentView.constraints.count > 0;
	//autoLayout
	if (autoLayout) {
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:cell.contentView
																	  attribute:NSLayoutAttributeWidth
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:nil
																	  attribute:NSLayoutAttributeWidth
																	 multiplier:1.f
																	   constant:contentViewWidth];
		[cell.contentView addConstraint:constraint];
		fittingSize = [cell.contentView systemLayoutSizeFittingSize:CGSizeMake(contentViewWidth, 0)];
		[cell.contentView removeConstraint:constraint];
		//frameLayout
	}else {
		
		BOOL inherited = ![cell isMemberOfClass:[UITableViewCell class]];
		BOOL overrided = [cell.class instanceMethodForSelector:@selector(sizeThatFits:)] != [UITableViewCell instanceMethodForSelector:@selector(sizeThatFits:)];
		if (inherited && !overrided) {
			NSAssert(NO, @"Must overrided sizeThatFits:");
		}
		fittingSize = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)];
	}
	if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
		fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
	}
	return fittingSize.height;
}


- (CGFloat)heightForRowWithIdentifier:(NSString *)identifier
					cachedForIndexPath:(NSIndexPath *)indexPath
						configuration:(void(^)(id cell))configuration {

	if (!identifier || !indexPath) {
		return 0;
	}
	
	if (!self.precacheEnabled) {
		self.precacheEnabled = YES;
		[self precacheIfNeeded];
	}
	
	
	if ([self.cache hasCachedCellHeightAtIndexPath:indexPath]) {
		return [self.cache cachedCellHeightAtIndexPath:indexPath];
	}
	CGFloat height = [self heightForRowWithIdentifier:identifier configuration:configuration];
	[self.cache cacheCellHeight:height atIndexPath:indexPath];
	return height;
}

- (BOOL)invalidate {
	return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setInvalidate:(BOOL)invalidate {
	objc_setAssociatedObject(self, @selector(invalidate), @(invalidate), OBJC_ASSOCIATION_RETAIN);
	self.precacheEnabled = NO;
	[self.cache.caches removeAllObjects];
}

@end
