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

@property(nonatomic,strong)UIView *views;
@property(nonatomic,strong)UIView *view2;


@end

@implementation aboutViewController

-(void)viewsf
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuback.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    self.views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49)];
    
    UIImageView *imgViews = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgViews.image = [UIImage imageNamed:@"back_about.jpg"];
    [self.views addSubview:imgViews];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight-49);
    effectView.alpha = 0.5;
    [imgViews addSubview:effectView];
    
    CGFloat h = kScreenHeight+64;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/5, h/5-50, kScreenWidth*3/5, 50)];
    //    label.backgroundColor = [UIColor blackColor];
    label.text = @"版权声明";
    label.textAlignment = 1;
    [self.views addSubview:label];
    
    
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(kScreenWidth/5, h/5, kScreenWidth*3/5, h*49/90)];
    textV.text=@"本app所有内容，包括文字、图片、音频、视频、软件等均在网上搜集\n访问者可将本app提供的内容或服务用于个人学习，研究或欣赏，以及其他非商业性或非盈利性用途，但同时应遵守著作权法及其他相关法律的规定，不得侵犯本app及相关权利人的合法权利。除此以外，本app任何内容或服务用于其他用途时，须征得本app及相关权利人的书面许可，并支付报酬。\n本app内容原作者如不愿意在本app刊登内容，请及时通知本app，予以删除。\n电子邮箱：315719250@qq.com";
    self.automaticallyAdjustsScrollViewInsets = NO;
    textV.editable = NO;
    [textV setFont:[UIFont fontWithName:@"Arial" size:20]];
    [self.views addSubview:textV];
    
    

    
    
    self.views.backgroundColor = [UIColor colorWithRed:0.410 green:0.386 blue:0.358 alpha:0.5];
    [self.view addSubview:self.views];
    
    
    UIButton *btns = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/5, h*67/90, kScreenWidth*3/5,h/18)];
    btns.backgroundColor = [UIColor grayColor];
    [btns addTarget:self action:@selector(Actions) forControlEvents:UIControlEventTouchUpInside];
    [btns setTitle:@"确定" forState:UIControlStateNormal];
    [self.views addSubview:btns];
}

-(void)view2f{
    CGFloat x = (kScreenWidth-80)/2;
    
    CGFloat y = ((kScreenHeight-49)-80)/2;
    
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view2];
    
    UIImageView *imgViews = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgViews.image = [UIImage imageNamed:@"back_about.jpg"];
    [self.view2 addSubview:imgViews];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y*11/10, 80, 80)];
    
    imgView.image = [UIImage imageNamed:@"logo.jpg"];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(0, y*5/12, kScreenWidth, (kScreenHeight-49)/15);
    [btn setTitle:@"GlobalTravel(点击详解)" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [btn addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSString *str_1 = @"(∩ᵒ̴̶̷̤⌔ᵒ̴̶̷̤∩)";
    UILabel *lable_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, y*14/9, kScreenWidth, (kScreenHeight-49)/8)];
    lable_1.text = str_1;
    lable_1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *label_5 = [[UILabel alloc]initWithFrame:CGRectMake(0, y*4/7, kScreenWidth, (kScreenHeight-49)/6)];
    label_5.text = @"感谢您的支持!";
    label_5.textAlignment = NSTextAlignmentCenter;
    
    [self.view2 addSubview:label_5];
    
    [self.view2 addSubview:lable_1];
    
    
    [self.view2 addSubview:btn];
    
    [self.view2 addSubview:imgView];
    
    
    UILabel *label_3 = [[UILabel alloc]initWithFrame:CGRectMake(0, (kScreenHeight-49)*9/10, kScreenWidth, (kScreenHeight-49)/20)];
    UILabel *label_4 = [[UILabel alloc]initWithFrame:CGRectMake(0, (kScreenHeight-49)*19/20, kScreenWidth, (kScreenHeight-49)/20)];
    label_3.text = @"版本 V1.0.0";
    label_4.text = @"(c)2016 蓝欧科技";
    
    label_4.font = [UIFont systemFontOfSize:12];
    label_4.textColor = [UIColor colorWithWhite:0.289 alpha:1.000];
    
    label_3.textAlignment = NSTextAlignmentCenter;
    label_4.textAlignment = NSTextAlignmentCenter;
    
    [self.view2 addSubview:label_3];
    [self.view2 addSubview:label_4];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于我们";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewsf];
    [self view2f];

}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Action
{
    //    [UIView transitionFromView:self.view2 toView:self.views duration:1 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
    [UIView transitionFromView:self.view2 toView:self.views duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.views];
    }];
}



-(void)Actions
{
    
    //    [UIView transitionFromView:self.views toView:self.view2 duration:1 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
    [UIView transitionFromView:self.views toView:self.view2 duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        [self.view sendSubviewToBack:self.view2];
    }];
    
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
