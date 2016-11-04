//
//  TipsCollectingVC.m
//  GlobalTravel
//
//  Created by lanou on 16/11/2.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "TipsCollectingVC.h"
#import "FMDBTool.h"
#import "UIImageView+WebCache.h"
#import "TravelingTipsCell.h"
#import "TravelingTipsModel.h"
#import "TipsWebVC.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface TipsCollectingVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableview;
@end

@implementation TipsCollectingVC
-(void)loadData
{
    self.dataArray = [FMDBTool searchTraviling];
}
#pragma mark 初始化tableView
-(void)tableDelegate
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = [UIImage imageNamed:@"background_4.JPG"];
    [self.view addSubview: imgView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"旅游攻略";
    
    
    UIImage *img = [UIImage imageNamed:@"back.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    [self tableDelegate];
    
//    [self loadData];
    
    //注册cell
    [self.tableview registerClass:[TravelingTipsCell class] forCellReuseIdentifier:@"cell"];
    
    
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TipsWebVC *webVC = [[TipsWebVC alloc]init];
    
    TravelingTipsModel *model = self.dataArray[indexPath.row];
    
    webVC.model  = model;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight/3;
}

#pragma mark cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelingTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TravelingTipsModel *model = self.dataArray[indexPath.item];
    cell.backgroundColor = [UIColor clearColor];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.p] placeholderImage:[UIImage imageNamed:@"background_3.jpg"]];
    cell.titleText.text = model.t;

    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
    [self.tableview reloadData];
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

@end
