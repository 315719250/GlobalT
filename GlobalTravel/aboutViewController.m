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
    
    self.views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    CGFloat h = kScreenHeight+64;
    
    
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(kScreenWidth/5, h/5, kScreenWidth*3/5, h*49/90)];
    textV.text=@"GlobalTravel，Written in November 2016, GlobalTravel is a new start of our entry into the iOS development, is committed to tourism strategy consulting. For public consumption concept, in November 2016 we successfully registered as a app, the theme of tourism, we have to enter the field of Internet iOS development. And we will provide you with the best quality of the world travel Raiders, while ensuring that real-time updates to ensure that users can have a new experience from time to time, so that you can rest assured. In our continuous efforts to develop, our app--------GlobalTravel will likely provide powerful new force for the development of iOS China. Our products have unlimited possibilities, we adhere to the team model operations, reduced due to personal errors and allow users to have unpleasant experience, we strive to do the best! For consumers in the first time to provide quality consulting and satisfactory service. Providing flexible and diverse consumer inquiries, reading and so on will not be subject to time and geographical constraints. Relying on the Internet the huge information, let you fully enjoy “home”, the quest for world convenience. As China iOS developed according to our strategic planning of the bright younger generation, GlobalTravel will be a flower, we build the world tourism. Treat all customers we have the information to provide the accuracy of the advantages of consulting and satisfactory service for the purpose, to first-class quality and superb Raiders iOS technology in the industry to win the reputation of the customer. We are adhering to the “development of the concept of quality is the root, honesty, morality first, integrity”, adhere to the “rigorous and realistic progressive unity” principle, continuous innovation. To serve as the core, as the highest purpose, dedication to provide experience comfort and meticulous service to the highest app. Set integrity, comfort, innovation in one, let you look at the peace of mind, with a comfortable! Enterprise mission: the pursuit of perfect quality, reduce conflict, so that a good product is better! Let the tourism become convenient! Core values: integrity management, customer comfort! Development concept: “quality is the root, honesty, morality first, to the letter based” pursuit of philosophy: to provide unlimited possibilities, app! Maybe we app now has some shortcomings, but please believe that we will make the infinite business revolution by all our team wisdom, a new field of infinite the";
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
    
    CGFloat y = (kScreenHeight-80)/2;
    
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.view2];
    
    UIImageView *imgViews = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgViews.image = [UIImage imageNamed:@"back_about.jpg"];
    [self.view2 addSubview:imgViews];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 80, 80)];
    
    imgView.image = [UIImage imageNamed:@"logo.jpg"];
    
    
    
    
    
    UIButton *btn_1 = [[UIButton alloc]initWithFrame:CGRectMake(0, y/3, kScreenWidth, kScreenWidth/6)];
    [btn_1 addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSString *str_1 = @"(∩ᵒ̴̶̷̤⌔ᵒ̴̶̷̤∩)";
    UILabel *lable_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, y*3/2, kScreenWidth, kScreenHeight/6)];
    lable_1.text = str_1;
    lable_1.textAlignment = NSTextAlignmentCenter;
    
    NSString *str_2 = @"GlobalTravel(点击详解)";
    
    UILabel *lable_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, y/3, kScreenWidth, kScreenHeight/6)];
    lable_2.text = str_2;
    lable_2.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *label_5 = [[UILabel alloc]initWithFrame:CGRectMake(0, y*4/7, kScreenWidth, kScreenHeight/6)];
    label_5.text = @"感谢您的支持!";
    label_5.textAlignment = NSTextAlignmentCenter;
    
    [self.view2 addSubview:label_5];
    
    [self.view2 addSubview:lable_2];
    [self.view2 addSubview:lable_1];
    
    
    [self.view2 addSubview:btn_1];
    
    [self.view2 addSubview:imgView];
    
    
    UILabel *label_3 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight*4/5, kScreenWidth, kScreenHeight/10)];
    UILabel *label_4 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight*9/10, kScreenWidth, kScreenHeight/10)];
    label_3.text = @"版本 V1.0.0";
    label_4.text = @"(c)2016 蓝欧科技";
    
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
    [UIView transitionFromView:self.view2 toView:self.views duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.views];
    }];
}



-(void)Actions
{
    
    //    [UIView transitionFromView:self.views toView:self.view2 duration:1 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
    [UIView transitionFromView:self.views toView:self.view2 duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
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
