//
//  FirstViewController.m
//  GlobalTravel
//
//  Created by lanou on 16/11/5.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"
#import "RelexMoment.h"
#import "AppDelegate.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface FirstViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl *page;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*4, kScreenHeight);
    
    for (int i =0; i<4; i++) {
        //导入图片
        NSString * imgName = [NSString stringWithFormat:@"000%d.jpg",i+1];
        UIImage * image = [UIImage imageNamed:imgName];
        //创建ImageView
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
        
        //创建毛玻璃样式
        UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        //创建一个view装毛玻璃样式
        UIVisualEffectView *effectView=[[UIVisualEffectView alloc]initWithEffect:effect];
        
        effectView.frame=CGRectMake(0, 0, kScreenWidth,kScreenHeight);
        
        effectView.alpha = 0.3;
        
        [imageView addSubview:effectView];
        
    }
    
    NSString * imgName3 = [NSString stringWithFormat:@"background.jpg"];
    UIImage * image = [UIImage imageNamed:imgName3];
    //创建ImageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight)];
    imageView.image = image;
    [self.scrollView addSubview:imageView];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    
    //创建毛玻璃样式
    UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    
    //创建一个view装毛玻璃样式
    UIVisualEffectView *effectView=[[UIVisualEffectView alloc]initWithEffect:effect];
    
    effectView.frame=CGRectMake(0, 0, kScreenWidth,kScreenHeight);
    
    effectView.alpha = 0.5;
    
    [imageView addSubview:effectView];
    

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(kScreenWidth*13/4, kScreenHeight*7/10, kScreenWidth/2, kScreenHeight/10);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"马上体验" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    UIImage *img = [UIImage imageNamed:@"003.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    [btn addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:img forState:UIControlStateNormal];
        [self.scrollView addSubview:btn];
    
    UILabel *label_01 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*16/5, kScreenHeight/5, kScreenWidth*3/5, kScreenHeight*3/5)];
    label_01.backgroundColor = [UIColor clearColor];
    label_01.text = @"一个人旅行，\n不理会繁杂的琐事，\n自由自在地，\n去体验一个城市，\n一段故事，\n留下一片欢笑。";
    label_01.numberOfLines = 6;
    //设置文本的字体
    label_01.font = [UIFont systemFontOfSize:25];
    
    [self.scrollView addSubview:label_01];
    
    NSArray *array = @[@"人生至少要有两次冲动，\n一为奋不顾身的爱情，\n一为说走就走的旅行。",@"旅行是为了离开，\n旅行是对庸常生活的一次越狱。",@"那个梦想中的自己，\n那个曾经丢失的自己，\n那个豁然开朗的自己。\n然后在世界的某个地方相聚，开怀。"];
    
    
    for (int i = 0; i<3; i++) {
        UILabel *label_01 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*(i*10+1)/10, kScreenHeight/10, kScreenWidth*4/5, kScreenHeight*4/5)];
        label_01.backgroundColor = [UIColor clearColor];
        label_01.text = array[i];
        label_01.numberOfLines = 6;
        //设置文本的字体
        label_01.font = [UIFont systemFontOfSize:25];
        
        [self.scrollView addSubview:label_01];
    }
    self.scrollView.delegate = self;
   
    
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 30)];
    [self.view addSubview:self.page];
    self.page.numberOfPages = 4;
    
    [self.page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
//    self.scrollView.contentOffset = CGPointMake(0, 0);
//    self.page.currentPage = 0;

    
    // Do any additional setup after loading the view.
}

-(void)pageAction:(UIPageControl * )page
{
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth *page.currentPage, 0) animated:YES];
}



#pragma mark 结束减速--停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self.page setCurrentPage:page];
}




-(UIViewController *)creatVCwithClass:(Class)class tittle:(NSString *)title
                          normalImage:(NSString *)normalImage
                        selectedImage:(NSString *)selectedImage
{
    UIViewController *vc=[[class alloc]init];
    
    UIImage *norImage=[UIImage imageNamed:normalImage];
    norImage = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selImage=[UIImage imageNamed:selectedImage];
    selImage=[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    vc.tabBarItem =[[UITabBarItem alloc]initWithTitle:title image:norImage selectedImage:selImage];
    
    return vc;
}



-(void)Action
{
    
    //创建视图
    //咨询
    ViewController *firstVC = (ViewController *)[self creatVCwithClass:[ViewController class] tittle:nil normalImage:@"zy.png" selectedImage:@"zy1.png"];
    
    
    //视频
    RelexMoment *relexVC = (RelexMoment *)[self creatVCwithClass:[RelexMoment class] tittle:nil normalImage:@"sp.png" selectedImage:@"sp1.png"];
    
    UINavigationController *firstNav=[[UINavigationController alloc]initWithRootViewController:firstVC];
    UINavigationController *relexNav=[[UINavigationController alloc]initWithRootViewController:relexVC];
    
    
    UITabBarController *tabbarVC=[[UITabBarController alloc]init];
    
    //    //被管理的视图控制器数组
    //    //数组中顺序为显示时从左到右的顺序
    //
    tabbarVC.viewControllers=@[firstNav,relexNav];
    //
    //
    //    //默认选中的视图控制器---下标
    tabbarVC.selectedIndex=0;
    //
    //设置被选中的视图控制器---控制器
    //    tabbarVC.selectedViewController=firstNav;
    
    //被选中的标题颜色--元素的颜色
    //tabbarVC.tabBar.tintColor = [UIColor redColor];
    
    //设置标签栏是否为半透明
    //tabbar的高度为--49
    //tabbar是否透明不影响self.view的高度
    //在self.view中添加子视图时注意高度不要被tabbar遮挡
    
    
    //    tabbarVC.tabBar.translucent=NO;
    
    tabbarVC.tabBar.barTintColor=[UIColor colorWithRed:0.937 green:0.865 blue:1.000 alpha:1.000];;
    
    //隐藏
    //   tabbarVC.tabBar.hidden=YES;
    
    //代理
//    tabbarVC.delegate = self;

    UIApplication *app =[UIApplication sharedApplication];
    AppDelegate *app2 = app.delegate;
    
 app2.window.rootViewController = tabbarVC;
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
