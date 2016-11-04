//
//  HelpVC.m
//  GlobalTravel
//
//  Created by lanou on 16/10/31.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "HelpVC.h"

@interface HelpVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)NSMutableArray *Answerarray;
@property(nonatomic,strong)NSMutableArray *problemarray;

@end

@implementation HelpVC

-(void)tableDelegate
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-64)];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

-(void)data
{
    NSString *problemStr1 = @"浏览过程中退出再进入会照成额外流量吗？";
    NSString *problemStr2 = @"已收藏的信息在收藏夹里会照成额外流量吗？";
    NSString *problemStr3 = @"当前版本号多少?";
    NSString *problemStr4 = @"为什么要清理缓存？";
    NSString *problemStr5 = @"东南亚是指那些地方？";
    NSString *problemStr6 = @"找不到老婆怎么办？";
    NSString *problemStr7 = @"工作累怎么办？";
    NSString *problemStr8 = @"不喜欢异性怎么办？";
    NSString *problemStr9 = @"去非洲旅游安全吗？";
    NSString *problemStr10 = @"中国有僵尸吗？埃及有木乃伊吗？欧洲有吸血鬼吗？在哪里能看到，我去那里旅游。";
    NSString *problemStr11 = @"伊甸园在哪？";
    NSString *problemStr12 = @"三亚有鲨鱼吗？";
    
    self.problemarray = [[NSMutableArray alloc]init];
    [self.problemarray addObject:problemStr1 ];
    [self.problemarray addObject:problemStr2 ];
    [self.problemarray addObject:problemStr3 ];
    [self.problemarray addObject:problemStr4 ];
    [self.problemarray addObject:problemStr5 ];
    [self.problemarray addObject:problemStr6 ];
    [self.problemarray addObject:problemStr7 ];
    [self.problemarray addObject:problemStr8 ];
    [self.problemarray addObject:problemStr9 ];
    [self.problemarray addObject:problemStr10 ];
    [self.problemarray addObject:problemStr11 ];
    [self.problemarray addObject:problemStr12 ];
    
    NSString *AnswerStr1 = @"不会的，请您放心，之前已经缓存在本地，不需要再加载。";
    NSString *AnswerStr2 = @"不会的，收藏的信息存在本地里，在调用是从本地调用，并不需要流量。";
    NSString *AnswerStr3 = @"当前版本号为1.0.0。";
    NSString *AnswerStr4 = @"清理缓存就像人一样，吃下去的东西总要排走的，不然就会越活越大只了。";
    NSString *AnswerStr5 = @"东南亚总共有11个国家：越南、老挝、柬埔寨、缅甸、泰国、马来西亚、新加坡、印度尼西亚（以下简称印尼）、菲律宾、文莱和东帝汶。";
    NSString *AnswerStr6 = @"那是您忙于事业而缺少与异性交往的机会，建议您多旅游，多遇几座森林说不定就有你要的那棵树。";
    NSString *AnswerStr7 = @"去旅游啊，看看风景约约X就好了。";
    NSString *AnswerStr8 = @"泰国7日游价格便宜又实惠，实在人干实在事。";
    NSString *AnswerStr9 = @"首先去医院多打针，非洲传染病太多，这个是主要的危险。";
    NSString *AnswerStr10 = @"有，有，都有。僵尸就藏在兵马俑里，木乃伊在金字塔里，吸血鬼在亲的梦里。";
    NSString *AnswerStr11 = @"在西方神话故事中";
    NSString *AnswerStr12 = @"三亚海湾都是浅海的，没有鲨鱼的，比如三亚湾，大东海，亚龙湾都没有鲨鱼的尽管放心的潜水和游泳，希望你玩的开心";
    
    self.Answerarray = [[NSMutableArray alloc]init];
    [self.Answerarray addObject:AnswerStr1];
    [self.Answerarray addObject:AnswerStr2];
    [self.Answerarray addObject:AnswerStr3];
    [self.Answerarray addObject:AnswerStr4];
    [self.Answerarray addObject:AnswerStr5];
    [self.Answerarray addObject:AnswerStr6];
    [self.Answerarray addObject:AnswerStr7];
    [self.Answerarray addObject:AnswerStr8];
    [self.Answerarray addObject:AnswerStr9];
    [self.Answerarray addObject:AnswerStr10];
    [self.Answerarray addObject:AnswerStr11];
    [self.Answerarray addObject:AnswerStr12];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"或许有这样的疑问";
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = [UIImage imageNamed:@"Help_background.jpg"];
    [self.view addSubview: imgView];

    
    [self tableDelegate];
    [self data];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuback.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    
    // Do any additional setup after loading the view.
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"answer = %@",self.Answerarray);
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"hello" message:self.Answerarray[indexPath.row] preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:cancelAction];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.problemarray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.view.frame.size.height-264)/6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];

        cell.textLabel.text = self.problemarray[indexPath.row];

       cell.textLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor clearColor];
    
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
