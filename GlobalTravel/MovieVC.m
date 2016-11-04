//
//  MovieVC.m
//  GlobalTravel
//
//  Created by lanou on 16/11/4.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "MovieVC.h"
#import "MovieCell.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
#import "TFHpple.h"
#define kScreendWidth [UIScreen mainScreen].bounds.size.width
#define kScreendHeight [UIScreen mainScreen].bounds.size.height
@interface MovieVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, assign) NSInteger i;

@end

@implementation MovieVC

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
                
                MovieModel *model=[[MovieModel alloc]init];
                
                NSDictionary *dic=dict[@"media"];
                
                model.cover_pic=dic[@"cover_pic"];
                model.recommend_caption=dict[@"recommend_caption"];
                //获取视频url
                model.VideoUrl = [self VideoJX:dic[@"url"]];
                
                NSDictionary *userDic=dic[@"user"];
                [model setValuesForKeysWithDictionary:userDic];
                
                
                [self.dataArray addObject:model];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [self.tableview reloadData];
                    
                });
                
                
            }
            
        }else
        {
            NSLog(@"error=%@",error);
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
    return vdUrl;
}
-(void)createtableview
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreendWidth, kScreendHeight-49) style:UITableViewStyleGrouped];
    self.tableview.separatorStyle = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.i = 1;
    [self loadData];
    
//    [self createtableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[MovieCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark UITabelView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreendHeight-115;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    MovieModel *model = self.dataArray[indexPath.row];
    [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [cell.secondImage sd_setImageWithURL:[NSURL URLWithString:model.cover_pic]];
    cell.nameLabel.text = model.screen_name;
    cell.titleLabel.text = model.recommend_caption;
    return cell;
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
