//
//  DataMessageBaseManaher.h
//  BoomNews
//
//  Created by 邵垚 on 15/7/25.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNSNewsModel;
@interface DataMessageBaseManaher : NSObject
//单例方法
+ (DataMessageBaseManaher *)shareDataBaseManager;

//操作数据库
//打开数据库

- (void)openDB;

//创建表
- (void)createTable;


//插入（增加）数据(单条)
- (void)insertMessage:(BNSNewsModel *)model;


//查询数据

//1.全部查找

- (NSArray *)selectAll;

//2.按条件查找
- (NSArray *)selectWithTitle:(NSString *)title;

//删除数据
- (void)deleteWithMessage:(NSString *)title;


//关闭数据库
- (void)closeDB;


//获取doucuments路径

- (NSString *)documentPath;
@end
