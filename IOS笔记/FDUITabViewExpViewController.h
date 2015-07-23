//
//  FDUITabViewExpViewController.h
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-12.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTransferDelegate.h"

@interface FDUITabViewExpViewController : UIViewController<FDTransferDelegate>

@property(nonatomic,weak) id<FDTransferDelegate> delegate;
@end
