//
//  Func.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "Func.h"
#import "FDJson.h"

@implementation Func

-(id)initWithDict:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
        _idCode=[dict[@"id"]intValue];
        _name=dict[@"name"];
        _src=dict[@"src"];
        _type=[dict[@"type"] intValue];
        NSArray *childs=dict [@"child"];
        NSMutableArray *children= [NSMutableArray array];
        for (int i=0; i<childs.count; i++) {
            NSDictionary *child=childs[i];
            Func *func=[[Func alloc]initWithDict:child];
            [children addObject:func];
        }
        _children=children;
    }
    return self;
}

@end
