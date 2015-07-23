//
//  FDURLCenter.h
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-7.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDURLCenter : NSObject

+(void)urlGet:(NSString *)url delegate:(id)delegate;

+(void)urlPost:(NSString *)url data:(NSData *)body delegate:(id)delegate;
@end
