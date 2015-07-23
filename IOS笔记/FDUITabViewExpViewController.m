//
//  FDUITabViewExpViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-12.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDUITabViewExpViewController.h"
#import "Func.h"

@interface FDUITabViewExpViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) Func *func;
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)NSArray *indicators;
@property(nonatomic,assign)BOOL isSection;
@end

@implementation FDUITabViewExpViewController

-(NSArray *)datas
{
    
    if (_datas == nil) {
        
        if (_isSection) {
            NSArray *da=@[@[@"Achol",@"Afe",@"Azol"],
                 @[@"Baodl",@"BiBi",@"Bko"],
                 @[@"Chol",@"Cici",@"Czo"],
                 @[@"Dac",@"Dic",@"Dwl",@"Dcv",@"Dxpooo",@"Dyo",@"Dzz"],
                 @[@"Ecdl",@"Ewdf",@"Epo"]
                 ];
            _datas=da;
        }
        else{
            NSArray *da=@[@"Achol",@"Afe",@"Azol",
                     @"Baodl",@"BiBi",@"Bko",
                     @"Chol",@"Cici",@"Czo",
                     @"Dac",@"Dic",@"Dwl",
                     @"Ecdl",@"Ewdf",@"Epo"
                     ];
            _datas=da;
            
        }
        NSMutableArray *arry=[NSMutableArray array];
        for (int i=0; i<_datas.count; i++) {
            [arry addObject:[NSString stringWithFormat:@"%c",(char)(65+i) ]];
        }
        if(self.func.idCode>=2103){
            _indicators=arry;
        }
        
    }
    return _datas;
}


-(void)transferData:(id)data
{
    if ([data isKindOfClass:[Func class]]) {
        self.func=(Func*)data;
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    CGRect _window=self.view.frame;
    //
    //不同的UITabView
    _isSection=self.func.idCode!=2101;
    
    UITableViewStyle style=_isSection?UITableViewStyleGrouped:UITableViewStylePlain;
    if(self.func.idCode==2103){
        style=UITableViewStylePlain;
    }
    
   
    CGRect tframe=self.view.frame;
    
    if (self.func.idCode>=2104) {
        UISearchBar *searchBar=[[UISearchBar alloc]init];
        
        searchBar.frame=CGRectMake(_window.origin.x
                                   , _window.origin.y+64, _window.size.width, 40);
         searchBar.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:searchBar];
        
        tframe.origin.y=104;
    }else{
        tframe=self.view.frame;
    }
    UITableView *tabview=[[UITableView alloc]initWithFrame:tframe style:style];
    tabview.dataSource=self;
    tabview.delegate=self;
    
    [tabview setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tabview];
    tabview.autoresizingMask=UIViewAutoresizingFlexibleWidth;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _isSection?self.datas.count:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _isSection?((NSArray *)self.datas[section]).count:self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TAG=@"tabcell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TAG];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TAG];
        cell.accessoryType=UITableViewCellAccessoryDetailButton;
    }
    cell.textLabel.text=_isSection?((NSArray *)self.datas[indexPath.section])[indexPath.row]:self.datas[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.indicators[section];
    
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indicators;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

@end





















