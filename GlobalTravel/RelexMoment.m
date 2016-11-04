//
//  RelexMoment.m
//  GlobalTravel
//
//  Created by john.zhang on 16/11/4.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "RelexMoment.h"
#import "UIImageView+WebCache.h"
#import "TFHpple.h"
#import "RelexMomentCell.h"
#import "RelexMomentModel.h"
#import "MJRefresh.h"
#define kScreendWidth [UIScreen mainScreen].bounds.size.width
#define kScreendHeight [UIScreen mainScreen].bounds.size.height
@interface RelexMoment ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, assign) NSInteger i;

@end

@implementation RelexMoment

-(void)loadData
{
 
    NSString *str=[NSString stringWithFormat:@"https://newapi.meipai.com/medias/topics_timeline.json?id=13&type=1&feature=new&page=%ld&channel=brandlinkpc&locale=1",self.i];
    
    //1.生成URL
    NSURL *url = [NSURL URLWithString:str];
    //2.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    
    //3.创建任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //解析数据
            for (NSDictionary *dict in array) {
                
                RelexMomentModel *model=[[RelexMomentModel alloc]init];
                
                NSDictionary *dic=dict[@"media"];
                
                model.cover_pic=dic[@"cover_pic"];
                model.recommend_caption=dict[@"recommend_caption"];
                model.VideoUrl = dic[@"url"];
                NSLog(@"HTML网页url：%@",dic[@"url"]);
         
                NSDictionary *userDic=dic[@"user"];
                [model setValuesForKeysWithDictionary:userDic];
                
                
                [self.dataArray addObject:model];
                
    
            }
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableview reloadData];
                
            });
            
        }
        else
        {
            NSLog(@"error=%@",error);
            NSLog(@"网络请求失败");
            
        }
    }];
    
    //4.开启任务
    [task resume];
    
    
}

//解析HTML数据获取到对应的MP4格式的视频url
-(NSString *)VideoJX:(NSString *)url;
{
    //解析HTML
    NSString *str = url;
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str]];
    
    TFHpple * doc = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements = [doc searchWithXPathQuery:@"//meta"];
    NSString *vdUrl;
    
    for (TFHppleElement * hppleElement in elements) {
        
        NSDictionary *dict = hppleElement.attributes;
        
        for (NSString *str in dict) {
            if ([str isEqualToString:@"content"]) {
                NSString *str1 = dict[str];
                if ([str1 containsString:@"https://"]&&[str1 containsString:@"mp4"]) {
                    //获取到对应的MP4格式的视频url
                    vdUrl = str1;
                }
            }
        }
    }
//    NSLog(@"%@",vdUrl);
    return vdUrl;
}

-(void)createtableview
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreendWidth, kScreendHeight) style:UITableViewStyleGrouped];
    self.tableview.separatorStyle = NO;
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
//        [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
//     dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
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
    
    
//     2.模拟3秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
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

    self.title = @"轻松一刻";
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.435 green:0.322 blue:0.658 alpha:1.000];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createtableview];
   
    
    [self setupRefresh];
    
    [self.tableview registerClass:[RelexMomentCell class] forCellReuseIdentifier:@"cell"];
}



#pragma mark UITabelView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreendHeight/2;
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
    RelexMomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    RelexMomentModel *model = self.dataArray[indexPath.row];
    [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [cell.secondImage sd_setImageWithURL:[NSURL URLWithString:model.cover_pic]];
    cell.nameLabel.text = model.screen_name;
    cell.titleLabel.text = model.recommend_caption;
    
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = kScreendHeight/2;
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的背景图片
    UIImage *normallImage = [UIImage imageNamed:@"bf.png"];
    UIImage *seletImage = [UIImage imageNamed:@"bf2.png"];
    [btn setBackgroundImage:normallImage forState:UIControlStateNormal];
    [btn setBackgroundImage:seletImage forState:UIControlStateHighlighted];
    btn.frame = CGRectMake((w-80)/2, h/2, 80,80);
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn];
    return cell;
}
-(void)btnclicked:(UIButton *)btn
{
//    btn.selected = !btn.selected;
    NSLog(@"点击了播放按钮");
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
