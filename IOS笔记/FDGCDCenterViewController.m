//
//  FDGCDCenterViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-5.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDGCDCenterViewController.h"
#import "Func.h"
@interface FDGCDCenterViewController()
@property(nonatomic,strong) Func *func;
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)UITextView *tv;
@property(nonatomic,strong)UIButton *bt;
@end
@implementation FDGCDCenterViewController

-(void)transferData:(id)data
{
    if ([data isKindOfClass:[Func class]]) {
        self.func=(Func*)data;
    }
}


-(NSDictionary *)dict
{
    if (_dict==nil) {
        NSDictionary *dict=@{
                             @"1101":@"主线程GCD",@"1102":@"后台线程GCD"
                             ,@"1103":@"一次性GCD",@"1104":@"延时GCD"
                             ,@"1105":@"合并"
                             };
        _dict=dict;
    }
    return _dict;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.func!=nil) {
        self.navigationItem.title=self.func.name;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    static int margin=10;
    int w=[UIScreen mainScreen].bounds.size.width-2*margin ;
    static int h=44;
    CGRect lastRect;
//    for (int i=0; i<self.dict.count; i++) {
        UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
//        button.titleLabel.text=self.dict[[NSString stringWithFormat:@"%d",self.func.idCode ]];
    [button setTitle:self.dict[[NSString stringWithFormat:@"%d",self.func.idCode ]]forState:UIControlStateNormal];
    button.backgroundColor=[UIColor orangeColor];
    button.titleLabel.tintColor=[UIColor redColor];
    button.titleLabel.textColor=[UIColor whiteColor];
        lastRect=CGRectMake(margin, 80, w, h);
        button.frame=lastRect;
    
    
        [self.view addSubview:button];
//        [button setTag:i];
        [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    _bt=button;
//    }
    _tv=[[UITextView alloc]initWithFrame:CGRectMake(margin, margin+CGRectGetMaxY(lastRect), CGRectGetWidth(lastRect),[UIScreen mainScreen].bounds.size.height-CGRectGetMaxY(lastRect)-margin)];
    [_tv setEditable:NO];
    [self.view addSubview:_tv];
}

-(void) btnClicked
{
    int tag=self.func.idCode;
    [self addLog:[NSString stringWithFormat:@"开始执行%@方法",self.dict[[NSString stringWithFormat:@"%d",self.func.idCode ]]]];
    if (tag==1101) {
        [self syncGcd];
    }
    else if (tag==1102) {
        [self asyncGcd];
    }
    else if (tag==1103) {
        [self onetimeGcd];
    }
    else if (tag==1104) {
        [self delayGcd];
    }
    else if (tag==1105) {
        [self managerGcd];
    }
}

-(void)addLog:(NSString *)log
{
    _tv.text=[NSString stringWithFormat:@"%@%@\n",_tv.text,log];
}

/**
 * 运行在主线程（UI线程）
 */
#pragma mark - 运行在主线程（UI线程）
- (void)syncGcd
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        [self addLog:[NSString stringWithFormat:@"%@",[NSThread currentThread]]];
        [self addLog:@"主线程GCD运行结束"];
    });
    [self addLog:@"syncGcd方法结束"];
}

/**
 * 运行在后台线程（非UI线程）
 */
#pragma mark - 运行在后台线程（非UI线程）
- (void)asyncGcd
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
        NSString *log=[NSString stringWithFormat:@"%@",[NSThread currentThread]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self addLog:log];
            [self addLog:@"后台线程GCD运行结束"];
        });
        
    });
    [self addLog:@"asyncGcd方法结束"];
}

/**
 * 一次运行
 * 不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的
 * 来防止使用多个线程或者队列时不同步的问题。
 */
#pragma mark - 一次运行
- (void)onetimeGcd
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        NSString *log=[NSString stringWithFormat:@"%@",[NSThread currentThread]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self addLog:log];
            [self addLog:@"【一次GCD运行结束】"];
        });
    });
    [self addLog:@"onetimeGcd方法结束"];
}

#pragma mark - 延迟执行
-(void)delayGcd
{
    // 延迟2秒执行：
    [self addLog:@"2秒后执行"];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString *log=[NSString stringWithFormat:@"%@",[NSThread currentThread]];
        [self addLog:log];
        [self addLog:@"【延迟GCD运行结束】"];
    });
}

#pragma mark - 执行后合并统计结果
-(void)managerGcd
{
    //
    // 合并汇总结果
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程一
        NSString *log=[NSString stringWithFormat:@"%@",[NSThread currentThread]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self addLog:log];
            [self addLog:@"线程一结束"];
        });

    });
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程二
        NSString *log=[NSString stringWithFormat:@"%@",[NSThread currentThread]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self addLog:log];
            [self addLog:@"线程二结束"];
        });
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        // 汇总结果
        NSString *log=[NSString stringWithFormat:@"%@",[NSThread currentThread]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //
            [self addLog:@"开始汇总"];
            [self addLog:log];
            [self addLog:@"线程一、二结束"];
        });
    });
}
#pragma mark - end

-(void) alert:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}
@end
