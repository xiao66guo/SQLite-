//
//  ViewController.m
//  SQLite的使用
//
//  Created by 小果 on 2017/2/5.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "ViewController.h"
#import "XGSQLiteManager.h"
#import "Person.h"
#import <NSObject+YYModel.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [XGSQLiteManager shareManager];
    [self morePerson2];
}

#pragma mark - 批量插入数据
// 模拟突然断电的情况
- (void)morePerson2 {
    NSLog(@"开始插入数据");
    // 开启事务
    [[XGSQLiteManager shareManager] execSQL:@"BEGIN TRANSACTION;"];
    
    NSTimeInterval start = CACurrentMediaTime();
    for (NSInteger i = 0; i < 10000;  i++) {
        NSString *name = [@"小明" stringByAppendingFormat:@"%zd",i];
        NSDictionary *dict = @{@"name":name, @"age":@18, @"height":@1.6};
        Person *p  = [Person yy_modelWithJSON:dict];
        
        [p insertPerson];
        
        // 突然断电的情况
        if (i == 1000) {
            // 回滚事务 - 就是恢复到建立快照之前的状态下
            [[XGSQLiteManager shareManager] execSQL:@"ROLLBACK TRANSACTION;"];
            
            break;
        }
    }
    // 提交事务
    [[XGSQLiteManager shareManager] execSQL:@"COMMIT TRANSACTION;"];
    
    NSLog(@"%f",CACurrentMediaTime() - start);
}


/*
 大批量的数据插入：
 1、开启事务（是从原来的数据库中重新建立一个数据库的‘快照’;
 2、在插入数据的时候，针对快照的数据库进行数据操作;
 3、当所有数据都操作完成后，再使用快照替换掉之前的副本
 
 使用事务的好处:
 1、可以保证数据的完整性;
 2、可以增加操作大量数据的速度;
 */
// 插入10000条数据要0.336720s
- (void)morePerson1 {
    NSLog(@"开始插入数据");
    // 开启事务
    [[XGSQLiteManager shareManager] execSQL:@"BEGIN TRANSACTION;"];
    
    NSTimeInterval start = CACurrentMediaTime();
    for (NSInteger i = 0; i < 10000;  i++) {
        NSString *name = [@"小明" stringByAppendingFormat:@"%zd",i];
        NSDictionary *dict = @{@"name":name, @"age":@18, @"height":@1.6};
        Person *p  = [Person yy_modelWithJSON:dict];
        
        [p insertPerson];
    }
    // 提交事务
    [[XGSQLiteManager shareManager] execSQL:@"COMMIT TRANSACTION;"];
    
    NSLog(@"%f",CACurrentMediaTime() - start);
}

/*
 在开发中，没有显式的开启事务的话，那么在插入每一条数据的时候就会开启一个事务，让后再提交；每一个数据库操作，都会默认开启事务，当操作完成后会自动提交事务
*/
// 10000条数据要14s
- (void)morePerson {
    NSLog(@"开始插入数据");
    
    NSTimeInterval start = CACurrentMediaTime();
    for (NSInteger i = 0; i < 10000; i++) {
        NSString *name = [@"小明" stringByAppendingFormat:@"%zd",i];
        NSDictionary *dict = @{@"name":name, @"age":@18, @"height":@1.6};
        Person *p  = [Person yy_modelWithJSON:dict];
        
        [p insertPerson];
    }
    NSLog(@"%f",CACurrentMediaTime() - start);
}

#pragma mark - 数据库操作
- (void)persons {
    NSLog(@"%@",[Person person]);
}

- (void)deleteDemo {
    NSDictionary *dict = @{@"id":@2,@"name":@"小松鼠",@"age":@25,@"height":@1.75};
    Person *p = [Person yy_modelWithJSON:dict];
    
    // 更新数据库
    if ([p deletePerson]) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
}

- (void)updateDemo {
    NSDictionary *dict = @{@"id":@1,@"name":@"小松鼠",@"age":@25,@"height":@1.75};
    Person *p = [Person yy_modelWithJSON:dict];
    
    // 更新数据库
    if ([p updatePerson]) {
        NSLog(@"更新数据成功 %@",p);
    }else{
        NSLog(@"更新数据失败");
    }
}

- (void)insertDemo {
    NSDictionary *dict = @{@"name":@"gua",@"age":@14,@"height":@1.76};
    Person *p = [Person yy_modelWithJSON:dict];
    
    // 插入数据库
    if ([p insertPerson]) {
        NSLog(@"插入数据成功 %@",p);
    }else{
        NSLog(@"插入数据失败");
    }
}


#pragma mark - 字典转模型
- (void)personDemo2 {
    NSArray *array = @[
                       @{@"name":@"zhangsan",@"age":@14,@"height":@1.76},
                       @{@"name":@"wangwu",@"age":@25,@"height":@1.56}
                       ];
    // 创建Person模型数组
    NSArray *persons = [NSArray yy_modelArrayWithClass:[Person class] json:array];
    NSLog(@"%@",persons);
}

- (void)personDemo1 {
    
    NSDictionary *dict = @{@"name":@"zhangsan",@"age":@14,@"height":@1.76};
    // 创建Person模型
    Person *p = [Person yy_modelWithJSON:dict];
    NSLog(@"%@",p);
}
@end
