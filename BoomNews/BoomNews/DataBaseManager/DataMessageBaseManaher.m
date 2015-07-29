//
//  DataMessageBaseManaher.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/25.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "DataMessageBaseManaher.h"
#import "BNSNewsModel.h"

#import <sqlite3.h>
@implementation DataMessageBaseManaher
+ (DataMessageBaseManaher *)shareDataBaseManager{
    
    
    static DataMessageBaseManaher *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataMessageBaseManaher alloc] init];
    });
    
    return manager;
    
    
}



#pragma mark --------- 获取documents路径

- (NSString *)documentPath{
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return array.firstObject;
    
}


//声明一个数据库对象
static sqlite3 *db = nil;

#pragma mark ---------- 打开数据库
- (void)openDB{
    
    //判断数据库是否打开
    if (db != nil) {
        //NSLog(@"数据库已经打开");
        return;
    }
    //如果没有打开，就打开数据库
    //拼接数据库路径
    NSString *dbPath = [[self documentPath]stringByAppendingPathComponent:@"BOOMMessageNews.sqlite"];
    NSLog(@"%@" , dbPath);
    
    //打开数据库
    int result = sqlite3_open(dbPath.UTF8String, &db);
    if (result == SQLITE_OK) {
        //NSLog(@"数据库打开成功");
    }else{
        
        //NSLog(@"数据库打开失败");
        
    }
    
    
    
}


//关闭数据库
- (void)createDB{
    //关闭数据库
    int result = sqlite3_close(db);
    //需要判断是否关闭成功
    if (result == SQLITE_OK) {
        //NSLog(@"数据库关闭成功");
    }else{
        
        //NSLog(@"数据库关闭失败");
        
    }
    
}

# pragma mark -------- 建表
- (void)createTable{
    //1.准备sql语句
    //建立表的sql语句
    NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS datamessage (title TEXT PRIMARY KEY NOT NULL,digest TEXT NOT NULL, imgsrc TEXT NOT NULL, skipID TEXT NOT NULL, skipType TEXT NOT NULL, specialID TEXT NOT NULL, docid TEXT NOT NULL, store INTEGER)";
    //2.执行语句
# pragma mark  ------ 改
    int result = sqlite3_exec(db, sqlStr.UTF8String, NULL, NULL, NULL);
    //3.判断是否执行成功
    if (result == SQLITE_OK) {
        //NSLog(@"建表成功");
    }else{
        
        //NSLog(@"建表失败");
        
    }
    
}

# pragma mark ------------ (增)插入数据
- (void)insertMessage:(BNSNewsModel *)model{
    
    //1.准备sql语句
    

    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO datamessage(title,digest,imgsrc,skipID,skipType,specialID,docid,store) VALUES ('%@' , '%@' , '%@' , '%@' , '%@' , '%@' , '%@', '%d')", model.title ,model.digest, model.imgsrc, model.skipID,model.skipType, model.specialID, model.docid, model.store];
    //NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO message(imgurl) VALUES ('%@')",model.imgurl];
    //2.执行语句
    
    char *error = NULL;
    int result = sqlite3_exec(db, insertSql.UTF8String, NULL, NULL, &error);
    
    //3.判断是否执行成功
    if (result == SQLITE_OK) {
        //NSLog(@"插入成功");
    }else{
        
        //NSLog(@"插入失败-----%s", error);
    }
    
}


//删除数据
- (void)deleteWithMessage:(NSString *)title{
    
    
    //1.准备sql语句
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM datamessage WHERE title='%@'" , title];
    
    //2.执行语句
    int result = sqlite3_exec(db, deleteSql.UTF8String, NULL , NULL, NULL);
    //3.判断
    if (result == SQLITE_OK) {
        //NSLog(@"删除成功");
    }else{
        
        //NSLog(@"删除失败");
    }
    
}

#pragma mark ----- 查找全部

- (NSArray *)selectAll{
    //先创建一个数组
    NSMutableArray *mutableArray = nil;
    //1.准备sql语句
    //对于查询语句比较特殊，带有一个指针，这个指针就做伴随指针
    NSString *seclectSql = @"SELECT *FROM datamessage";
    //2.创建一个伴随数据
    sqlite3_stmt *stmt = nil;
    
    //3.sql语句的判断，执行
    int result = sqlite3_prepare_v2(db, seclectSql.UTF8String, -1, &stmt, NULL);
    
# pragma mark ------ 判断语句是否成功
    if (result == SQLITE_OK) {
        
        //存储查询出的数据
        mutableArray = [[[NSMutableArray alloc]init] autorelease];
        
        
        //判断是否还有数据
        //使用while循环来判断每行的数据，while适用于知道循环次数的时候
        
        //通过伴随指针来查询
        while (sqlite3_step(stmt) == SQLITE_ROW) {
			
			int index = 0;
            //NSInteger number = sqlite3_column_int(stmt, 0);
            NSString *titleStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index)];
            NSString *digestStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index+1)];
            NSString *imgsrcStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index+2)];
            NSString *skipIDStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index+3)];
            
            
            NSString *skipTypeStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index+4)];
            NSString *specialIDStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index+5)];
            NSString *docidStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, index+6)];

			NSInteger store = sqlite3_column_int(stmt, index+7);
            //创建person对象,数据模型
            BNSNewsModel *model = [[BNSNewsModel alloc] init];
            
            
            //把数据模型里面的数据取出赋值
            model.title = titleStr;
            model.digest = digestStr;
            model.imgsrc = imgsrcStr;
            model.skipID = skipIDStr;
            model.skipType = skipTypeStr;
            model.specialID = specialIDStr;
            model.docid = docidStr;
			model.store = store;

            
            [mutableArray addObject:model];
            [model release];
            
        }
        
        sqlite3_finalize(stmt);
     
    }
    //找到数组 可以返回
    return mutableArray;
}



/*
- (NSArray *)selectWithTitle:(NSString *)title{
    //先创建一个数组
    NSMutableArray *mutableArray = nil;
    //1.准备sql语句
    //对于查询语句比较特殊，带有一个指针，这个指针就做伴随指针
    NSString *seclectSql = @"SELECT *FROM datamessage WHERE title=?";
    //2.创建一个伴随数据
    
    sqlite3_stmt *stmt = nil;
    
    //3.sql语句的判断，执行
    int result = sqlite3_prepare_v2(db, seclectSql.UTF8String, -1, &stmt, NULL);
    
# pragma mark ------ 判断语句是否成功
    if (result == SQLITE_OK) {
        
        //存储查询出的数据
        mutableArray = [[[NSMutableArray alloc]init] autorelease];
        //NSLog(@"%@", titleStr);
        //NSLog(@"__________%@",title);
        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);
        //判断是否还有数据
        //使用while循环来判断每行的数据，while适用于知道循环次数的时候
        
        //通过伴随指针来查询
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //NSInteger number = sqlite3_column_int(stmt, 0);
            NSString *titleStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *digestStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *imgsrcStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *skipIDStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            NSString *skipTypeStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString *specialIDStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString *docidStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            
            //创建person对象,数据模型
            BNSNewsModel *model = [[BNSNewsModel alloc] init];
            
            
            //把数据模型里面的数据取出赋值
            model.title = titleStr;
            model.digest = digestStr;
            model.imgsrc = imgsrcStr;
            model.skipID = skipIDStr;
            model.skipType = skipTypeStr;
            model.specialID = specialIDStr;
            model.docid = docidStr;
            
            
            [mutableArray addObject:model];
            [model release];
            
        }
        
        sqlite3_finalize(stmt);
        //NSLog(@"查询成功");
    }
    return mutableArray;
}

*/

@end
