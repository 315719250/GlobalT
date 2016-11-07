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
#import "TYVideoPlayer.h"
#import "TYVideoPlayerView.h"
#import "TYVideoPlayerController.h"
#import "VedioCollectingVC.h"
#import "FMDBTool.h"
#import "VedioController.h"

#define kScreendWidth [UIScreen mainScreen].bounds.size.width
#define kScreendHeight [UIScreen mainScreen].bounds.size.height
@interface RelexMoment ()<UITableViewDataSource,UITableViewDelegate,TYVideoPlayerDelegate>

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, assign) NSInteger i;

@property (nonatomic, strong) TYVideoPlayer *videoPlayer;
@property (nonatomic, weak) TYVideoPlayerView *playerView;
@property(nonatomic,strong)UIView *vedioView;

//点击全屏穿的视频url
@property(nonatomic,strong)NSString *url;
//HTML的url
@property(nonatomic,strong)NSString *HTMLurl;

//监听播放状态
@property(nonatomic,assign)NSInteger isPaly;


//播放按钮
@property(nonatomic,strong)UIButton *btn1;

//爱心按钮
@property(nonatomic,strong)UIButton *btn2;
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
                model.caption=dic[@"caption"];
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
            [self.tableview headerEndRefreshing];
            [self createAlert];
            NSLog(@"error=%@",error);
            NSLog(@"网络请求失败");
        }
        
    }];
    
    //4.开启任务
    [task resume];
    
    
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
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreendWidth, kScreendHeight) style:UITableViewStylePlain];
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

//收藏夹按钮
-(void)CollectedBtn
{
    UIImage *img = [UIImage imageNamed:@"collect.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(collectAction)];
    
    self.navigationItem.rightBarButtonItem = menuBtn;
}
//收藏夹点击事件
-(void)collectAction{
    NSLog(@"点击了收藏夹");
    
    [self.videoPlayer pause];
    
    VedioCollectingVC *vc = [[VedioCollectingVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
    
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"轻松一刻";
    
    //创建收藏按钮
    [self CollectedBtn];
    
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

//返回分区高度
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
    
    cell.selectionStyle = NO;
    
    return cell;
    
}


//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VedioController *vc = [[VedioController alloc]init];
    
    RelexMomentModel *m = self.dataArray[indexPath.row];
    vc.model =m;
    
    vc.VedioUrl =[self VideoJX:m.VideoUrl];
    
    [self.navigationController pushViewController:vc animated:YES];
}



//继承于scrollView的方法
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
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
