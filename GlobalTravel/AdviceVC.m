//
//  AdviceVC.m
//  GlobalTravel
//
//  Created by lanou on 16/10/31.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "AdviceVC.h"
#define kScreenWidth self.view.frame.size.width
#define kScreenHeight (self.view.frame.size.height-64)


@interface AdviceVC ()

@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)UILabel *lable2;
@property(nonatomic,strong)UILabel *lable3;
@property(nonatomic,strong)UILabel *lable4;
@property(nonatomic,strong)UILabel *lable5;

@end



@implementation AdviceVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见与反馈";

    self.view.backgroundColor = [UIColor whiteColor];


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuback.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    

    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = [UIImage imageNamed:@"backAdvice.jpg"];
    [self.view addSubview:imgView];
    
    self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight/36+64, kScreenWidth-20, kScreenHeight/6)];
    self.lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight*2/9+64, kScreenWidth-20, kScreenHeight/6)];
    self.lable3 = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight*15/36+64, kScreenWidth-20, kScreenHeight/6)];
    self.lable4 = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight*22/36+64, kScreenWidth-20, kScreenHeight/6)];
    self.lable5 = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight*29/36+64, kScreenWidth-20, kScreenHeight/6)];
    
    
    self.lable1.text = @"感谢您愿意给我们意见";
    self.lable2.text = @"下面是我们的工作邮箱，您有任何疑问都可以跟我们交流";
    self.lable3.text = @"315719250@qq.com";
    self.lable4.text = @"我们保证在第一时间答复您的疑问！";
    self.lable5.text = @"我们真诚的希望您能给予我们宝贵的意见，谢谢！";
    
    self.lable1.font = [UIFont systemFontOfSize:40];
    
    self.lable2.font = [UIFont systemFontOfSize:30];
    self.lable3.font = [UIFont systemFontOfSize:25];
    self.lable4.font = [UIFont systemFontOfSize:20];
    self.lable5.font = [UIFont systemFontOfSize:15];
    
    self.lable1.numberOfLines = 0;
    self.lable2.numberOfLines = 0;
    
    self.lable1.textAlignment = NSTextAlignmentCenter;
    self.lable2.textAlignment = NSTextAlignmentCenter;
    self.lable3.textAlignment = NSTextAlignmentCenter;
    self.lable4.textAlignment = NSTextAlignmentCenter;
    self.lable5.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.lable1];
    [self.view addSubview:self.lable2];
    [self.view addSubview:self.lable3];
    [self.view addSubview:self.lable4];
    [self.view addSubview:self.lable5];
    
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
