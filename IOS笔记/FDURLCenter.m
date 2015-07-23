//
//  FDURLCenter.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-7.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDURLCenter.h"

@implementation FDURLCenter


//代理方法实现异步请求 <NSURLConnectionDataDelegate\NSURLConnectionDelegate>
+(void)urlGet:(NSString *)url delegate:(id)delegate
{
    NSString *urlStr=[NSString stringWithFormat:@"http://www.baidu.com/"];
    urlStr= [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *nsurl=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:nsurl];
    
    NSURLConnection* con=[NSURLConnection connectionWithRequest:request delegate:delegate];
    [con start];
}

//代理方法实现异步请求 <NSURLConnectionDataDelegate\NSURLConnectionDelegate>
+(void)urlPost:(NSString *)url data:(NSData *)body delegate:(id)delegate
{
    NSString *urlStr=[NSString stringWithFormat:@"http://www.baidu.com/"];
    urlStr= [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *nsurl=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:nsurl];
    request.HTTPMethod=@"POST";
    request.HTTPBody=body;
    NSURLConnection* con=[NSURLConnection connectionWithRequest:request delegate:delegate];
    [con start];
}
@end
