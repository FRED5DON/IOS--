//
//  FDAsyncGCBViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDAsyncGCBViewController.h"

@interface FDAsyncGCBViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
- (IBAction)closeModalView:(id)sender;
- (IBAction)asyncGcd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *desc;
- (IBAction)mainGcd:(id)sender;

- (IBAction)busGcd:(id)sender;

@end

@implementation FDAsyncGCBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _desc.text=[NSString stringWithContentsOfFile:@"notes.html" encoding:NSUTF8StringEncoding error:NULL];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeModalView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)asyncGcd:(id)sender {
    [self alert:@"dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{});"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // something
        [self connect];
    });
    
}

-(void) alert:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)connect
{
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com/"]];
    [[NSURLConnection connectionWithRequest:request delegate:self]start];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [self alert:[NSString stringWithFormat:@"NSData://%@",data.description ]];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self alert:[NSString stringWithFormat:@"Error://%@",error.description ]];
}


- (IBAction)mainGcd:(id)sender {
}

- (IBAction)busGcd:(id)sender {
}
@end
