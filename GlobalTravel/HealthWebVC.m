//
//  HealthWebVC.m
//  GlobalTravel
//
//  Created by lanou on 16/11/1.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "HealthWebVC.h"
#import <WebKit/WebKit.h>

#import "FMDBTool.h"

@interface HealthWebVC ()<WKNavigationDelegate,WKUIDelegate>

//用来显示网页内容
@property (nonatomic, strong) WKWebView *wkView;

@end

@implementation HealthWebVC

#pragma mark wkView的懒加载
-(WKWebView *)wkView
{
    if (_wkView == nil) {
        CGRect frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
        _wkView = [[WKWebView alloc] initWithFrame:frame];
        _wkView.scrollView.bounces=NO;

    }
    
    return _wkView;
}
-(void)createBtn
{
    //设置收藏按钮
    UIImage *norImage =  [UIImage imageNamed:@"4.png"];
    norImage = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selImage =  [UIImage imageNamed:@"5.png"];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0 , 0, 50, 30);
    [btn setImage:norImage forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    
    //设置按钮选中状态
    btn.selected = NO;
    NSArray *arr = [FMDBTool searchTravelHealth];
    for (TravelingHealthModel *m in arr) {
        if ([m.fromurl isEqualToString:self.model.fromurl]) {
            btn.selected = YES;
        }
    }
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    
    UIImage *leftImage = [UIImage imageNamed:@"1.png"];
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    [self createBtn];
    
    
    //添加webView
    
    [self.view addSubview:self.wkView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 64)];
    label.text = self.model.t;
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
//    label.backgroundColor = [UIColor whiteColor];
//    label.text = @"本文本源于网路数据，感谢浏览";
//    [self.view addSubview:label];
    
    
    //加载webView数据
    NSURL *url = [NSURL URLWithString:self.model.fromurl];
    NSLog(@"跳转网络页面:%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.wkView loadRequest:request];
}
#pragma mark 返回按钮响应方法
-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 收藏按钮响应方法
- (void)editAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [FMDBTool addTravelHealth:self.model];
    }else
    {
        [FMDBTool deleteTravelHealth:self.model];
    }
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 类似UIWebView的 -webViewDidStartLoad:  页面开始加载时调用
    NSLog(@"页面开始加载");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行
    decisionHandler(WKNavigationResponsePolicyAllow);
    
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
