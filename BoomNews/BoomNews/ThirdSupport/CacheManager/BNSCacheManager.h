//
//  BNSCacheManager.h
//  BoomNews
//
//  Created by jsix lei on 15/7/24.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNSCacheManager : NSObject

+ (instancetype)defaultManager;

//计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path;

//清理缓存文件
- (void)clearCache:(NSString *)path;

@end
