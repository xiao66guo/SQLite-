//
//  XGSQLiteManager.h
//  SQLite的使用
//
//  Created by 小果 on 2017/2/5.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  数据库管理工具
 */
@interface XGSQLiteManager : NSObject

+(instancetype)shareManager;

/**
 *  执行SQL
 *
 *  @param sql sql 语句
 *
 *  @return 是否成功
 */
- (BOOL)execSQL:(NSString *)sql;
/**
 *  末次插入数据的自增长 id
 */
- (NSInteger)lastRowId;
@end
