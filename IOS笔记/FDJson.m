//
//  FDJson.m
//  LostWorld
//
//  Created by MacBook On Dell on 15-4-20.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDJson.h"

@implementation FDJson

+(id) jsonWithString:(NSString *)jsonstr
{
    NSError *error;
    id json=[NSJSONSerialization JSONObjectWithData:[jsonstr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    if (error==nil) {
        return json;
    }
    return error;
}

+(id)jsonWithPath:(NSString *)path
{
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    NSError *error;
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error==nil) {
        return json;
    }
    return error;
}

+(id) getValue:(NSString *)key with:(NSDictionary *)json
{
    return [json objectForKey:key];
}

@end
