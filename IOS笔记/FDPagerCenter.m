//
//  FDPagerCenter.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDPagerCenter.h"
#import "Func.h"
#import "FDFunctionTableViewController.h"
#import "FDAsyncGCBViewController.h"
#import "FDTransferDelegate.h"
#import "FDDetailTextController.h"
#import "FDGCDCenterViewController.h"
#import "FDUITabViewExpViewController.h"
#import "FDHardwareViewController.h"

@implementation FDPagerCenter


+(UIViewController *)pagerWith:(NSObject *)func
{
    UIViewController *ctrl;
    if ([func isKindOfClass:[Func class]]) {
        Func *f=(Func *)func;
        if (f.idCode/2100==1 && f.idCode%2100<100) {
            FDUITabViewExpViewController *controller=[[FDUITabViewExpViewController alloc]init];
            controller.delegate=controller;
            if ([controller respondsToSelector:@selector(transferData:)]) {
                [controller transferData:func];
            }
            ctrl=controller;
        }
        else if (f.idCode/4100==1 && f.idCode%4100<100) {
            FDHardwareViewController *controller=[[FDHardwareViewController alloc]init];
            controller.delegate=controller;
            if ([controller respondsToSelector:@selector(transferData:)]) {
                [controller transferData:func];
            }
            ctrl=controller;
        }
        else{
            FDGCDCenterViewController *controller = [[FDGCDCenterViewController alloc]init];
            controller.delegate=controller;
            if ([controller respondsToSelector:@selector(transferData:)]) {
                [controller transferData:func];
            }
            ctrl=controller;
        }
    }
    
    return ctrl;
}

+(UIViewController *)pagerDetailWith:(NSObject *)func
{
    UINavigationController *controller=[[UINavigationController alloc]init];
    FDDetailTextController *webview=[[FDDetailTextController alloc]init];
    webview.delegate=webview;
    if ([webview respondsToSelector:@selector(transferData:)]) {
        [webview transferData:func];
    }
    [controller addChildViewController:webview];
    return controller;
}


+(UIViewController *)pagerNavigationWith:(NSObject *)func
{
    FDFunctionTableViewController *controller = [[FDFunctionTableViewController alloc]initWithStyle:UITableViewStylePlain];
    controller.delegate=controller;
    if ([controller respondsToSelector:@selector(transferData:)]) {
        [controller transferData:func];
    }
    return controller;
}


@end
