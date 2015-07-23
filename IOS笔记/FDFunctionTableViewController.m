//
//  FDFunctionTableViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-5.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDFunctionTableViewController.h"
#import "Func.h"
#import "FDPagerCenter.h"

@interface FDFunctionTableViewController ()


@property(nonatomic,strong) Func *func;
@end

@implementation FDFunctionTableViewController



-(void)transferData:(id)data
{
    if ([data isKindOfClass:[Func class]]) {
        self.func=(Func *)data;
//        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];
    UIBarButtonItem *backBt=[[UIBarButtonItem alloc]init];
    backBt.title=@"返回";
    self.navigationItem.backBarButtonItem=backBt;
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.func!=nil) {
        self.navigationItem.title=self.func.name;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.func.children.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tag=@"childTabCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tag];
        cell.accessoryType=UITableViewCellAccessoryDetailButton;
    }
    
    Func *f=self.func.children[indexPath.row];
    // Configure the cell...
    cell.textLabel.text=f.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self showModalView:indexPath];
}

-(void) showModalView:(NSIndexPath *)indexPath
{
    Func *f=self.func.children[indexPath.row];
    [self.navigationController presentViewController:[FDPagerCenter pagerDetailWith:f] animated:YES completion:^{
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Func *f=self.func.children[indexPath.row];
    UIViewController *ctrler;
    if(f.type==1)
    {
        [self showModalView:indexPath];
    }
    else if(f.type==11)
    {
        ctrler=[FDPagerCenter pagerWith:f];
        if (ctrler!=nil) {
            [self.navigationController pushViewController:ctrler animated:YES];
        }
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
