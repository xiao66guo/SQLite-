//
//  Person.m
//  SQLite的使用
//
//  Created by 小果 on 2017/2/5.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "Person.h"
#import <NSObject+YYModel.h>
#import "XGSQLiteManager.h"
@implementation Person

#pragma mark - 数据库操作方法
// 更新和删除存在一个共同的问题：如果记录不存在，会正常执行 SQL,不会报错
- (BOOL)deletePerson {
    // 1、准备sql
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM T_Person WHERE id = %zd;",_id];
    
    // 2、执行sql
    // 1> 获取单例
    XGSQLiteManager *manager = [XGSQLiteManager shareManager];
    
    // 2> 执行sql
    [manager execSQL:sql];
    
    // 如果删除 1 行，返回成功
    return manager.changeRows == 1;
}

- (BOOL)updatePerson {
    // 1、准备sql
    NSString *sql = [NSString stringWithFormat:@"UPDATE T_Person SET name = '%@', age = %d, height = %f WHERE id = %zd;",_name, _age, _height, _id];
    
    // 2、执行sql
    // 1> 获取单例
    XGSQLiteManager *manager = [XGSQLiteManager shareManager];
    
    // 2> 执行sql
    [manager execSQL:sql];
    
    // 3> 如果更新行数 == 1,表示成功
    return manager.changeRows == 1;
}

- (BOOL)insertPerson {
    // 1、准备sql
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO T_Person (name, age, height) VALUES ('%@', '%d', '%f')",_name, _age, _height];
    
    // 2、执行sql
    // 1> 获取单例
    XGSQLiteManager *manager = [XGSQLiteManager shareManager];
    
    // 2> 执行sql - 只是单纯的执行 sql 将对象信息插入到数据库，但是没有更新 id,id是自增长，有数据库负责
    [manager execSQL:sql];
    
    // 记录id
    _id = [manager lastRowId];
    
    return _id > 0;
}


-(NSString *)description {
    return [self yy_modelDescription];
}
@end
