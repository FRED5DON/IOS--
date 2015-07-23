//
//  FirstViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDFunctionsTableViewController.h"
#import "FDJson.h"
#import "Func.h"
#import "FDPagerCenter.h"

@interface FDFunctionsTableViewController ()

@property(nonatomic,strong) NSArray *funcs;

@end

@implementation FDFunctionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id json=[FDJson jsonWithPath:@"functions.json"];
    NSMutableArray *array=[NSMutableArray array];
    if ([json isKindOfClass:[NSArray class]]) {
        NSArray *j=(NSArray *)json;
        for (int i=0; i<j.count; i++) {
            NSDictionary *root= j[i];
            Func *func=[[Func alloc]initWithDict:root];
            [array addObject:func];
        }
        [self setFuncs:array];
    }
    [self.tableView setShouldGroupAccessibilityChildren:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((Func *)_funcs[section]).name;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self funcs].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tag=@"function_single";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     }
    Func *func=((Func *)_funcs[indexPath.section]).children[indexPath.row];
    cell.textLabel.text=func.name;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel * head=[[UILabel alloc]init];
//    head.text=((Func *)_funcs[section]).name;
//    return head;
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Func *func=_funcs[section];
    return func.children.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Func *func=((Func *)_funcs[indexPath.section]).children[indexPath.row];
    UIViewController *ctrler=[FDPagerCenter pagerNavigationWith:func];
    if (ctrler!=nil) {
        [self.navigationController pushViewController:ctrler animated:YES];
//        ctrler.modalPresentationStyle=UIModalPresentationFullScreen;
//        ctrler.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
//        [self.navigationController presentViewController:ctrler animated:YES completion:^{
//        }];
    }
    
}

@end





















