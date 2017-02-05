//
//  Person.m
//  SQLite的使用
//
//  Created by 小果 on 2017/2/5.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "Person.h"
#import <NSObject+YYModel.h>
@implementation Person

-(NSString *)description {
    return [self yy_modelDescription];
}
@end
