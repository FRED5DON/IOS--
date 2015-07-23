//
//  Func.h
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Func : NSObject

@property(nonatomic,assign) int idCode;

#pragma mark - 类型（即将触发的页面类型）
@property(nonatomic,assign) int type;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,strong) NSArray *children;

@property(nonatomic,copy) NSString *src;

-(id)initWithDict:(NSDictionary *)dict;
@end
