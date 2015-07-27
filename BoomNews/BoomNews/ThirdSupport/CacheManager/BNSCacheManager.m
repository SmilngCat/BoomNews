//
//  BNSCacheManager.m
//  BoomNews
//
//  Created by jsix lei on 15/7/24.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSCacheManager.h"
#import "SDImageCache.h"

static BNSCacheManager *defaultManager = nil;

@implementation BNSCacheManager

#pragma mark - singleton

+ (instancetype)defaultManager {
	
	if (!defaultManager) {
		defaultManager = [[BNSCacheManager alloc] init];
	}
	return defaultManager;
}

- (instancetype)allocWithZone:(NSZone *)zone {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		defaultManager = [super allocWithZone:zone];
	});
	return defaultManager;
}

//计算单个文件大小
- (CGFloat)fileSizeAtPath:(NSString *)path{
	NSFileManager *fileManager=[NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:path]){
		long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
		return size/1024.0/1024.0;
	}
	return 0;
}

//计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
	NSFileManager *fileManager=[NSFileManager defaultManager];
	CGFloat folderSize = 0.0f;
	if ([fileManager fileExistsAtPath:path]) {
		NSArray *childerFiles=[fileManager subpathsAtPath:path];
		for (NSString *fileName in childerFiles) {
			NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
			folderSize += [self fileSizeAtPath:absolutePath];
		}
		//SDWebImage框架自身计算缓存的实现
		folderSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
		return folderSize;
	}
	return 0;
}

- (void)clearCache:(NSString *)path{
	NSFileManager *fileManager=[NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:path]) {
		NSArray *childerFiles=[fileManager subpathsAtPath:path];
		for (NSString *fileName in childerFiles) {
			//如有需要，加入条件，过滤掉不想删除的文件
			NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
			[fileManager removeItemAtPath:absolutePath error:nil];
		}
	}
	[[SDImageCache sharedImageCache] cleanDisk];
}

@end
