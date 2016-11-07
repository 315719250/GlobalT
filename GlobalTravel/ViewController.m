//
//  ViewController.m
//  GlobalTravel
//
//  Created by john.zhang on 16/10/24.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"
#import "RESideMenu.h"
#import "aboutViewController.h"
#import "UIImageView+WebCache.h"
#import "TravelHealthVC.h"
#import "CollectingVC.h"
#import "FacilitiesVC.h"
#import "HikingVC.h"
#import "AdviceVC.h"
#import "HelpVC.h"


#import "TravelingTipsVC.h"

#define kScreenWidth self.view.bounds.size.width

#define kScreenHeight self.view.bounds.size.height

@interface ViewController ()<SDCycleScrollViewDelegate>
{
    UIScrollView *demoContainerView;
    
}

@property(nonatomic,strong)RESideMenu *sideMenu;

@end

@implementation ViewController

//加载背景图片和ScrollView
-(void)loadBackground
{
    //间隔 30，轮播图高度h
    CGFloat h = (kScreenHeight - 130 ) / 2;
    
    //背景ScrollView
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.435 green:0.322 blue:0.658 alpha:1.000];
    
    demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 4*h+230);
    [self.view addSubview:demoContainerView];
    
    self.navigationItem.title = @"Global Travel";

    
}

//加载轮播图
-(void)CycleScrollViewDemo{
    // >>>>>>>>>>>>>>>>>>>>>>>>> 旅行攻略 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    //间隔 30，轮播图高度h
    CGFloat h = (kScreenHeight - 130 ) / 2;
    
    NSArray *arrayhot = @[@"TravelingTips_1.jpg",
                       @"TravelingTips_2.jpg",
                       @"TravelingTips_3.jpg",
                       @"TravelingTips_4.jpg"];
    
    SDCycleScrollView *cycleScrollViewH = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 70, kScreenWidth, h) shouldInfiniteLoop:YES imageNamesGroup:arrayhot];
    
    cycleScrollViewH.delegate = self;
    
//    cycleScrollViewH.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
    cycleScrollViewH.showPageControl = NO;
    
    cycleScrollViewH.layer.cornerRadius = 20;
    cycleScrollViewH.clipsToBounds = YES;
    
    [demoContainerView addSubview:cycleScrollViewH];
    cycleScrollViewH.autoScrollTimeInterval = 5;
    //添加手势
    UITapGestureRecognizer *tapGestH = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(favoriteAction:)];
    [cycleScrollViewH addGestureRecognizer:tapGestH];
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> 旅行健康 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    NSArray *array = @[@"TravelHelth_1.jpg",
                       @"TravelHelth_2.jpg",
                       @"TravelHelth_3.jpg",
                       @"TravelHelth_4.jpg"];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, h+100, kScreenWidth, h) shouldInfiniteLoop:YES imageNamesGroup:array];
    
    cycleScrollView.delegate = self;
    
//    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
    cycleScrollView.showPageControl = NO;
    
    cycleScrollView.layer.cornerRadius = 20;
    cycleScrollView.clipsToBounds = YES;
    
    [demoContainerView addSubview:cycleScrollView];
    cycleScrollView.autoScrollTimeInterval = 5;
    //添加手势
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(domestic:)];
    [cycleScrollView addGestureRecognizer:tapGest];
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> 旅行工具 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    NSArray *array1 = @[@"TravelEquipment_1.jpg",
                        @"TravelEquipment_2.jpg",
                        @"TravelEquipment_3.jpg",
                        @"TravelEquipment_4.jpg"];
    
    SDCycleScrollView *cycleScrollView1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 2*h+130, kScreenWidth, h) shouldInfiniteLoop:YES imageNamesGroup:array1];
    
    cycleScrollView1.delegate = self;
    
//    cycleScrollView1.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView1.showPageControl = NO;
    
    cycleScrollView1.layer.cornerRadius = 20;
    cycleScrollView1.clipsToBounds = YES;
    
    [demoContainerView addSubview:cycleScrollView1];
    cycleScrollView1.autoScrollTimeInterval = 10;
    //添加手势
    UITapGestureRecognizer *tapGest1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Overseas:)];
    [cycleScrollView1 addGestureRecognizer:tapGest1];
    
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> 徒步旅行 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    NSArray *array2 = @[@"Hike_1.jpg",
                        @"Hike_2.jpg",
                        @"Hike_3.jpg",
                        @"Hike_4.jpg"];
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 3*h+160, kScreenWidth, h) shouldInfiniteLoop:YES imageNamesGroup:array2];
    
    cycleScrollView2.delegate = self;
    
//    cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView2.showPageControl=NO;
    
    cycleScrollView2.layer.cornerRadius = 20;
    cycleScrollView2.clipsToBounds = YES;
    
    [demoContainerView addSubview:cycleScrollView2];
    cycleScrollView2.autoScrollTimeInterval = 10;
    //添加手势
    UITapGestureRecognizer *tapGest2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(island:)];
    [cycleScrollView2 addGestureRecognizer:tapGest2];
    
}
//菜单按钮
-(void)menu
{

    UIImage *img = [UIImage imageNamed:@"menu.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];
    
    self.navigationItem.leftBarButtonItem = menuBtn;
}

//收藏按钮
-(void)CollectedBtn
{
    UIImage *img = [UIImage imageNamed:@"collect.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(collectAction)];
    
    self.navigationItem.rightBarButtonItem = menuBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.translucent = NO;

    [self menu];
    [self CollectedBtn];

    [self loadBackground];
    
    [self CycleScrollViewDemo];
    

}

#pragma mark 手势
//旅行攻略
-(void)favoriteAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了旅行攻略");
    
//    FavouriteViewController *favVC = [[FavouriteViewController alloc]init];
    TravelingTipsVC *vc = [[TravelingTipsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    

}
//旅行健康
-(void)domestic:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了旅行健康");
//    DomesticViewController *domesticVC = [[DomesticViewController alloc]init];
    
    TravelHealthVC *vc = [[TravelHealthVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//旅行工具
-(void)Overseas:(UITapGestureRecognizer *)tap
{
//    OverseasViewController *overseasVC = [[OverseasViewController alloc]init];
    FacilitiesVC *vc = [[FacilitiesVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"点击了旅行工具"); 
}
//徒步旅行
-(void)island:(UITapGestureRecognizer *)tap
{
//    IslandViewController *islandVC = [[IslandViewController alloc]init];
    HikingVC *vc= [[HikingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"点击了徒步旅行");
}


#pragma mark MenuAction
//菜单点击
-(void)menuAction{
    NSLog(@"点击了菜单");
    
    if (!self.sideMenu) {
        
        //设置-清除缓存
        RESideMenuItem *testItemClean = [[RESideMenuItem alloc]initWithTitle:@"清除缓存" action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSLog(@"点击了清除缓存");
            
            //获取缓存路径
            NSString *path = [self localPath];
            //计算缓存大小
            CGFloat num = [self folderSizeAtPath:path];
//            NSLog(@"缓存大小：%f,目录：%f",[self fileSizeAtPath:path],[self folderSizeAtPath:path]);
            
            NSString *str = [NSString stringWithFormat:@"缓存大小%.2f M",num];
            //提示框--成功
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:str preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //清除
                [self clearCache:path];
            }];
            
            UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //返回
                [self dismissViewControllerAnimated:YES completion:nil];
            }];

            
            [alertController addAction:alertAction2];
            [alertController addAction:alertAction];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.sideMenu hide];
                
            [self presentViewController:alertController animated:YES completion:nil];
            });

        }];
        
        //设置
        RESideMenuItem *testItem = [[RESideMenuItem alloc]initWithTitle:@"设置" action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSLog(@"点击了设置");
        }];
        testItem.subItems = @[testItemClean];
        
        //关于
        RESideMenuItem *testItem1 = [[RESideMenuItem alloc]initWithTitle:@"关于" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
            //关闭菜单
            [self.sideMenu hide];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                aboutViewController *aboutVC = [[aboutViewController alloc]init];
                [self.navigationController pushViewController:aboutVC animated:YES];
            });

            
            NSLog(@"点击了关于");
        }];
        
        //帮助
        RESideMenuItem *testItem2 = [[RESideMenuItem alloc]initWithTitle:@"帮助" action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSLog(@"点击了帮助");
            
            //关闭菜单
            [self.sideMenu hide];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                HelpVC *helpVC = [[HelpVC alloc]init];
                [self.navigationController pushViewController:helpVC animated:YES];
            });
            
        }];
        
//        //评分
//        RESideMenuItem *testItem3 = [[RESideMenuItem alloc]initWithTitle:@"评分" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"点击了评分");
//        }];
        
        //意见反馈
        RESideMenuItem *testItem4 = [[RESideMenuItem alloc]initWithTitle:@"意见反馈" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
            //关闭菜单
            [self.sideMenu hide];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                AdviceVC *adVC = [[AdviceVC alloc]init];
                [self.navigationController pushViewController:adVC animated:YES];

            });
            
            NSLog(@"点击了意见反馈");
            
        }];
        
        
        self.sideMenu = [[RESideMenu alloc]initWithItems:@[testItem,testItem1,testItem2,testItem4]];
        self.sideMenu.backgroundImage = [UIImage imageNamed:@"background.jpg"];
    }
    
    [self.sideMenu show];
}

#pragma mark CollectAction

//收藏夹点击事件
-(void)collectAction{
    
//    CollectingViewController *collectingVC = [[CollectingViewController alloc]init];
    CollectingVC *vc = [[CollectingVC alloc]init];
    [self.navigationController pushViewController:vc  animated:YES];
    NSLog(@"收藏夹");
}



#pragma mark 清除缓存
//缓存路径
-(NSString *)localPath
{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    return doc;
}

//计算目录大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
      //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//计算缓存大小
-(float)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//清理缓存
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    
    //弹框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"清理完成" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //返回
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:alertAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:alertController animated:YES completion:nil];
    });

}
#pragma mark - SDCycleScrollViewDelegate

//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    NSLog(@"---点击了第%ld张图片", (long)index);
//    
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
