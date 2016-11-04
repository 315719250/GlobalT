//
//  aboutViewController.m
//  GlobalTravel
//
//  Created by john.zhang on 16/10/27.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "aboutViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface aboutViewController ()

@end

@implementation aboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuback.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];


    
    CGFloat x = (kScreenWidth-80)/2;
    
    CGFloat y = (kScreenHeight-80)/2;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 80, 80)];
    
    imgView.image = [UIImage imageNamed:@"logo.jpg"];
    [self.view addSubview:imgView];

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
