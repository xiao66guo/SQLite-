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
    [self updateDemo];
}

#pragma mark - 数据库操作

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
