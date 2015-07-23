//
//  FDPagerCenter.h
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface FDPagerCenter : NSObject

+(UIViewController *)pagerWith:(NSObject *)func;

+(UIViewController *)pagerDetailWith:(NSObject *)func;

+(UIViewController *)pagerNavigationWith:(NSObject *)func;
@end
