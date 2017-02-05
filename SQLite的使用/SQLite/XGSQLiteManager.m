//
//  XGSQLiteManager.m
//  SQLite的使用
//
//  Created by 小果 on 2017/2/5.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGSQLiteManager.h"
#import <sqlite3.h>

/**
 *  SQLite 开发是纯 C 语言的，所有的函数都是以 sqlite3_ 开头的
 */
@implementation XGSQLiteManager{
    /**
     *  全局数据库操作句柄,一定要有 ‘*’
     */
    sqlite3 *_db;
}

+ (instancetype)shareManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 在第一次调用单例的时候，会打开数据库
        [self openDataBaseWithName:@"my.db"];
    }
    return self;
}

#pragma mark - 数据库操作方法
- (NSInteger)lastRowId {
    // 返回最后一条插入数据的自增长 id
    return sqlite3_last_insert_rowid(_db);
}

/**
 *  在 sql 的开发中，绝大多数的代码都是一样的，只是 sql 不同
 *  本质上都是在执行 sql 指令
 */
- (BOOL)execSQL:(NSString *)sql {
    /**
     参数：
     1、数据库句柄
     2、sql 语句的 C 语言字符串
     3、sql 执行完毕回调的函数地址，通常传入 NULL
     4、参数3的第一个参数地址，通常传入 NULL
     5、错误信息的地址，通常传入 NULL
     
     返回值 SQLITE_OK 表示正确
     */
    return sqlite3_exec(_db, sql.UTF8String, NULL, NULL, NULL) == SQLITE_OK;
}

#pragma mark - 私有方法
/**
 *  打开数据库
 */
- (void)openDataBaseWithName:(NSString *)dbName {
    /**
     参数：
     1、数据库文件保存在沙河中的全路径的 C 语言字符串
     2、数据库 “句柄”，负责‘全局’操作数据库
     
     返回值
     如果成功返回  SQLITE_OK
     
     功能：
     1、如果数据库不存在，会新建并打开数据库
     2、如果数据库已经存在，会直接打开数据库
     */
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [docDir stringByAppendingPathComponent:dbName];
    
    if (sqlite3_open(path.UTF8String, &_db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    }
    NSLog(@"打开成功：%@",path);
    
    // 2、创建数据表
    if ([self createTable]) {
        NSLog(@"创表成功");
    }else{
        NSLog(@"创表失败");
    }
}

#pragma mark - 创建数据表
/**
 *  创建 db.sql 的脚本，将所有创表的 sql 保存内，一次性读取并且执行
 *
 *  在 db.sql 中还可以添加注释
 */
- (BOOL)createTable {
    // 1、准备SQL
    // 1>从bundle 中获取 db.sql 的路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"db.sql" ofType:nil];
    // 2> 从filePath中读取字符串
    NSString *sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    // 2、执行SQL
    return [self execSQL:sql];
}


- (BOOL)createTable2 {
    // 1、准备 sql
    NSString *sql = @"CREATE TABLE \n"
        @"IF NOT EXISTS 'T_Person' (\n"
        @"'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,\n"
        @"'name' TEXT,\n"
        @"'age' INTEGER,\n"
        @"'height' REAL\n"
   @");";
    
    NSLog(@"%@",sql);
    // 2、执行 sql 并且返回结果
    return [self execSQL:sql];
}
@end
