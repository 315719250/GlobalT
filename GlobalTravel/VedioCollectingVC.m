//
//  VedioCollectingVC.m
//  GlobalTravel
//
//  Created by john.zhang on 16/11/5.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "VedioCollectingVC.h"
#import "UIImageView+WebCache.h"
#import "TFHpple.h"
#import "RelexMomentCell.h"
#import "RelexMomentModel.h"
#import "TYVideoPlayer.h"
#import "TYVideoPlayerView.h"
#import "TYVideoPlayerController.h"
#import "FMDBTool.h"
#import "VedioController.h"


#define kScreendWidth [UIScreen mainScreen].bounds.size.width
#define kScreendHeight [UIScreen mainScreen].bounds.size.height
@interface VedioCollectingVC ()<UITableViewDataSource,UITableViewDelegate,TYVideoPlayerDelegate>

@property(nonatomic,strong)UITableView *tableview;

@property (nonatomic ,strong) NSArray *dataArray;
@property (nonatomic, strong) TYVideoPlayer *videoPlayer;
@property (nonatomic, weak) TYVideoPlayerView *playerView;
@property(nonatomic,strong)UIView *vedioView;

@end

@implementation VedioCollectingVC

-(void)loadData
{
    self.dataArray = [FMDBTool searchVedio];
    
    [self.tableview reloadData];
}

-(void)createtableview
{
    UIView *nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    nav.backgroundColor = [UIColor colorWithRed:0.435 green:0.322 blue:0.658 alpha:1.000];
    [self.view addSubview:nav];
    
    self.title = @"收藏夹";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(5, 17, 50, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreendWidth, kScreendHeight-64) style:UITableViewStylePlain];
    self.tableview.separatorStyle = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"收藏夹_轻松一刻";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [UIImage imageNamed:@"back.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self createtableview];
    
    [self loadData];
    [self.tableview registerClass:[RelexMomentCell class] forCellReuseIdentifier:@"cell"];
    [self.view sendSubviewToBack:self.vedioView];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
