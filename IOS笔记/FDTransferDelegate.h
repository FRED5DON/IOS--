//
//  FDTransferDelegate.h
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-5.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FDTransferDelegate <NSObject>

@optional
/**
 * 正向传递数据
 */
-(void)transferData:(id)data;

/**
 * 正向传递数据 附加回调
 */
//-(void)transferData:(id)data withBlock:(^void)callback;


@end
