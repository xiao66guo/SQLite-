//
//  Person.h
//  SQLite的使用
//
//  Created by 小果 on 2017/2/5.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  个人模型
 */
@interface Person : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) float height;

/**
 *  将当前对象插入到数据库
 */
- (BOOL)insertPerson;

/**
 *  将当前对象的内容更新到数据库
 */
- (BOOL)updatePerson;

/**
 *  将当前对象从数据库中删除
 */
- (BOOL)deletePerson;

/**
 *  返回数据库中所有 person 的模型数组
 */
+(NSArray <Person *>*)person;
@end
