//
//  FDDetailTextController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-5.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDDetailTextController.h"
#import "Func.h"

@interface FDDetailTextController()<UIWebViewDelegate>
@property(nonatomic,strong) Func *func;
@property(nonatomic,strong) UIWebView *webview;
@end


@implementation FDDetailTextController

-(Func *)func
{
    if (_func==nil) {
        _func=[[Func alloc]init];
        _func.name=@"";
        _func.idCode=-100;
        _func.src=@"404.html";
    }
    return _func;
}


-(void)transferData:(id)data
{
    if ([data isKindOfClass:[Func class]]) {
        self.func=(Func*)data;
    }
}

-(void)closeDetailController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    CGRect bounds=[UIScreen mainScreen].bounds;
    UIView *root=[[UIView alloc]initWithFrame:bounds];
    
    UITextView *tv=[[UITextView alloc]initWithFrame:bounds];
    tv.backgroundColor=[UIColor blackColor];
    tv.text=@"网页由freddon整理提供\nEmail:gsiner@live.com\nQQ:419102565";
    tv.textColor=[UIColor whiteColor];
    tv.textAlignment=NSTextAlignmentCenter;
//    [root addSubview:tv];
//    [self.view addSubview:tv];
    self.webview=[[UIWebView alloc]initWithFrame:bounds];
    self.webview.delegate=self;
    self.webview.backgroundColor=[UIColor clearColor];
    NSString* path = [[NSBundle mainBundle] pathForResource:self.func.src ofType:@""];
    if (path==nil) {
        path = [[NSBundle mainBundle] pathForResource:@"404.html" ofType:@""];
    }
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webview loadRequest:request];
    [root addSubview:self.webview];
    self.view=root;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(closeDetailController)] ;
    
//    for (id subview in self.webview.subviews){
//        if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
//            ((UIScrollView *)subview).bounces = NO;
//        }
//    }
//    
//    for (UIView* subView in [self.webview subviews]) {
//        if ([subView isKindOfClass:[UIScrollView class]]) {
//            for (UIView* shadowView in [subView subviews]) {
//                if ([shadowView isKindOfClass:[UIImageView class]]) {
//                    [shadowView setHidden:YES];
//                }
//            }
//        }
//    }
    //[self.webview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"webbg.png"]]];
    self.webview.autoresizingMask=UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    }

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 1.拼接Javacript代码
    NSString *js = [NSString stringWithFormat:@"window.location.href = '#%d';",self.func.idCode];
    // 2.执行JavaScript代码
    [self.webview stringByEvaluatingJavaScriptFromString:js];
}


//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    return YES;
//}


@end
