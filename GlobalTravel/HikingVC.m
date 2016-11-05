//
//  HikingVC.m
//  GlobalTravel
//
//  Created by lanou on 16/11/2.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "HikingVC.h"
#import "HikingCell.h"
#import "HikingModel.h"
#import "HikingWebVC.h"
#import "GDataXMLNode.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface HikingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic, assign)NSInteger i;

@end

@implementation HikingVC

//数据解析
-(void)loadData
{
    NSString *str = [NSString stringWithFormat:@"http://apps.caredsp.com/openinterface/gethelperbypage.ashx?page=%ld&pagesize=10&classes=%%E6%%97%%85%%E6%%B8%%B8%%E6%%94%%BB%%E7%%95%%A5%%E7%%99%%BE%%E7%%A7%%91_%%E5%%BE%%92%%E6%%AD%%A5%%E6%%97%%85%%E8%%A1%%8C&deviceTypeId=1&typeid=7",self.i];
    
    NSURL *url=[NSURL URLWithString:str];
    
    //创建请求
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];
    //设置最大的网络等待时间
    //    request.timeoutInterval=20.0;
    
    //获取主队列
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    //发起请求
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            //如果请求成功，拿到服务器返回的数据
            //解析XML数据
            //将数据存入到解析器中
            GDataXMLDocument *xmlDocu = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
            
            //节点对象
            //根节点
            GDataXMLElement *rootElement =[xmlDocu rootElement];
            
            //获取所有子节点
            NSArray *GLArr = rootElement.children;
            for (GDataXMLElement *Element in GLArr) {
                
                NSArray *array2 = Element.attributes;
                HikingModel *model = [[HikingModel alloc]init];
                for (GDataXMLNode *node in array2) {
                    
                    NSString *n =[node stringValue];
                    //输出key，value值
                    //                    NSLog(@"key: %@",node.name);
                    //                    NSLog(@"Value :%@",n);
                    
                    [model setValue:n forKey:node.name];
                    
                }
                
                [self.dataArray addObject:model];
                
            }
            //            for (TravelingTipsModel *item in self.mArray) {
            //
            //                NSLog(@"title:%@,url:%@",item.t,item.fromurl);
            //            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableview reloadData];
                
            });
            
        }
        else
        {
            [self.tableview headerEndRefreshing];
            [self createAlert];
            NSLog(@"网络请求失败");
        }
        
    }];
    
    
}
-(void)createAlert
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"您的网络不通，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.tableview reloadData];
        NSLog(@"已经点确定");
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)createtableview
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableview.separatorStyle = NO;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    [self.tableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableview.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableview.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableview.headerRefreshingText = @"正在帮你刷新中,不客气";
    
    self.tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableview.footerRefreshingText = @"正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    if (self.dataArray.count == 0) {
        self.i = 1;
        [self loadData];
    }else{
        
        [self.dataArray removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
        self.i=1;
        [self loadData];
        
    }
    
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.tableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableview headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    if (self.i == 0) {
        self.i = 1;
        self.i += 1;
        [self loadData];
    }else{
        self.i += 1;
        [self loadData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableview footerEndRefreshing];
    });
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = [UIImage imageNamed:@"background_4.jpg"];
    [self.view addSubview: imgView];
    
    
    self.navigationItem.title = @"徒步旅游";
    
    
    self.i = 1;
    
    UIImage *img = [UIImage imageNamed:@"2.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];;
    
    [self createtableview];
    
    //数据解析
//    [self loadData];
    
    
    // 集成刷新控件
    [self setupRefresh];
    
    
    //注册cell
    
    [self.tableview registerClass:[HikingCell class] forCellReuseIdentifier:@"cell"];
}
//返回主页
-(void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark UITableview代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kScreenHeight-64)/3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HikingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HikingModel *model = self.dataArray[indexPath.row];
    
//    NSLog(@"图片：%@",model.p);
//    NSLog(@"标题:%@",model.t);
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.p] placeholderImage:[UIImage imageNamed:@"background_4.jpg"]];
    cell.titleLabel.text = model.t;
    cell.contextLabel.text = model.n;
    cell.dateLabel.text = model.date;
    cell.fromLabel.text = model.from;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HikingWebVC *webVC = [[HikingWebVC alloc]init];
    
    HikingModel *model = self.dataArray[indexPath.row];
    
    webVC.model = model;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.navigationController.navigationBarHidden = NO;

    [self.navigationController pushViewController:webVC animated:YES];
    
    NSLog(@"点击了cell");
}

//页面已经显示
-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//继承于scrollView的方法
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tableview.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) ;
    }
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
