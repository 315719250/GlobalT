//
//  VedioVC.m
//  GlobalTravel
//
//  Created by john.zhang on 16/11/5.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "VedioVC.h"

@interface VedioVC ()

@end

@implementation VedioVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = self.model.recommend_caption;


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
