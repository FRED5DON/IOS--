//
//  FDJson.h
//  LostWorld
//
//  Created by MacBook On Dell on 15-4-20.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDJson : NSObject
//将字符串转换成JSON（字典 或数组） 错误则返回NSError
+(id) jsonWithString:(NSString *)jsonstr;

+(id)jsonWithPath:(NSString *)path;

//从字典取值
+(id) getValue:(NSString *)key with:(NSDictionary *)json;

@end
