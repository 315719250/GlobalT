//
//  AppDelegate.m
//  GlobalTravel
//
//  Created by john.zhang on 16/10/24.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "XHLaunchAd.h"
#import "ViewController.h"
#import "RelexMoment.h"


//动态广告
#define ImgUrlString @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"

@interface AppDelegate ()<UITabBarControllerDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    /**
     *  启动页广告
     */
    [self example];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**
 *  启动页广告
 */
-(void)example
{
    /**
     *  1.显示启动页广告
     */
    [XHLaunchAd showWithAdFrame:CGRectMake(0, 0,self.window.bounds.size.width, self.window.bounds.size.height-150) setAdImage:^(XHLaunchAd *launchAd) {
        
        //向服务器请求广告数据
        [self requestImageData:^(NSString *imgUrl, NSInteger duration, NSString *openUrl) {
            
            //设置广告数据
            [launchAd setImageUrl:imgUrl duration:duration skipType:SkipTypeTimeText options:XHWebImageDefault completed:^(UIImage *image, NSURL *url) {
                
                
                //异步加载图片完成回调(若需根据图片尺寸,刷新广告frame,可在这里操作)
                //weakLaunchAd.adFrame = ...;
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.window.bounds.size.height-150, self.window.bounds.size.width, 150)];
                
                label.textAlignment = 1;
//                label.text  = @"Global Travel";
                
                label.font = [UIFont systemFontOfSize:50];
                
                [self.window addSubview:label];
                
                
            } click:^{
                
                
                NSLog(@"click");
            }];
            
            
            
        }];
        
        
    } showFinish:^{
        //广告展示完成回调,设置window根控制器
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        
        self.window.rootViewController=[self createTabbarController];

    }];
}

/**
 *  模拟:向服务器请求广告数据
 *
 *  @param imageData 回调imageUrl,及停留时间,跳转链接
 */
-(void)requestImageData:(void(^)(NSString *imgUrl,NSInteger duration,NSString *openUrl))imageData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(imageData)
        {
            //http://www.returnoc.com/
            imageData(ImgUrlString,5,@"http://place.qyer.com/china/travel-notes/?from_device=app");
        }
    });
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
-(UITabBarController *)createTabbarController
{
    //创建视图
    //咨询
    ViewController *firstVC = (ViewController *)[self creatVCwithClass:[ViewController class] tittle:@"" normalImage:@"zy.png" selectedImage:@"zy1.png"];
    
    //视频
    RelexMoment *relexVC = (RelexMoment *)[self creatVCwithClass:[RelexMoment class] tittle:@"" normalImage:@"sp.png" selectedImage:@"sp1.png"];
    
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
    tabbarVC.delegate = self;
    
    
    
    return tabbarVC;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
