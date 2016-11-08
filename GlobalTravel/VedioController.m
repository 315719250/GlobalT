//
//  VedioController.m
//  GlobalTravel
//
//  Created by john.zhang on 16/11/6.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "VedioController.h"
#import "FMDBTool.h"
#import "TYVideoPlayer.h"
#import "TYVideoPlayerView.h"
#import "UIImageView+WebCache.h"
#import "TFHpple.h"




#define kScreendWidth [UIScreen mainScreen].bounds.size.width
#define kScreendHeight [UIScreen mainScreen].bounds.size.height

@interface VedioController ()<TYVideoPlayerDelegate>

@property(nonatomic,strong)UIImageView *headImgView;

@property(nonatomic,strong)UILabel *AuthorName;

@property(nonatomic,strong)UILabel *descLabel;

@property (nonatomic,strong)UIButton *btn;

@property (nonatomic, strong) TYVideoPlayer *videoPlayer;
@property (nonatomic, weak) TYVideoPlayerView *playerView;


@end

@implementation VedioController


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
    NSArray *arr = [FMDBTool searchVedio];
    for (RelexMomentModel *m in arr) {
        if ([m.VideoUrl isEqualToString:self.model.VideoUrl]) {
            btn.selected = YES;
        }
    }
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *img = [UIImage imageNamed:@"2.png"];
    //设置图片本身不被修改
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//收藏按钮
-(void)editAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [FMDBTool addVedio:self.model];
    }else
    {
        [FMDBTool deleteVedio:self.model];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"视频";
    [self createBtn];
    [self createUI];
    
    [self addPlayerView];
    [self addVideoPlayer];
    [self loadVideo];
}


-(void)createUI
{
    //头像
    self.headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 74, kScreendWidth/5, kScreendWidth/5)];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar]];
    self.headImgView.layer.cornerRadius =kScreendWidth/5/2;
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.clipsToBounds = YES;
    //发布者名称
    self.AuthorName = [[UILabel alloc]initWithFrame:CGRectMake(kScreendWidth/3, kScreendHeight/10, kScreendWidth *2/3, kScreendHeight/10)];
    self.AuthorName.text = self.model.screen_name;
    
    //描述
    self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,kScreendHeight/1.6, kScreendWidth-20, kScreendHeight/2.5)];
    self.descLabel.numberOfLines=0;
    self.descLabel.text = self.model.caption;
    
    UIImage *norImage =  [UIImage imageNamed:@"action.png"];
    norImage = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selImage =  [UIImage imageNamed:@"stop.png"];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame=CGRectMake((kScreendWidth-50)/2 , kScreendHeight/1.5, 50, 50);
    [self.btn setImage:norImage forState:UIControlStateNormal];
    [self.btn setImage:selImage forState:UIControlStateSelected];
    [self.btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮选中状态
    self.btn.selected = NO;
    
    
    [self.view addSubview:self.headImgView];
    [self.view addSubview:self.AuthorName];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.descLabel];
    
}
-(void)Action:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
//视频布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    _playerView.frame  = CGRectMake(0, (kScreendHeight-103-CGRectGetWidth(self.view.frame)*9/16)/2, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)*9/16);
    
    _playerView.frame = CGRectMake(10, kScreendHeight/4, kScreendWidth-20,(kScreendWidth-20)*12/16);
}

- (void)addPlayerView
{
    TYVideoPlayerView *playerView = [[TYVideoPlayerView alloc]init];
    playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [_playerView addGestureRecognizer:tap];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (_videoPlayer.isPlaying) {
        [_videoPlayer pause];
    }else{
        [_videoPlayer play];
    }
}

- (void)addVideoPlayer
{
    TYVideoPlayer *videoPlayer = [[TYVideoPlayer alloc]init];
    videoPlayer.delegate = self;
    _videoPlayer = videoPlayer;

}

//加载视频
- (void)loadVideo
{
//    NSString *urlString =self.VedioUrl;
    NSURL *streamURL = [NSURL URLWithString:self.VedioUrl];
    [_videoPlayer loadVideoWithStreamURL:streamURL playerLayerView:_playerView];
    _videoPlayer.track.continueLastWatchTime = YES;
    
}

#pragma mark - TYVideoPlayerDelegate

- (void)videoPlayer:(TYVideoPlayer*)videoPlayer track:(id<TYVideoPlayerTrack>)track didChangeToState:(TYVideoPlayerState)toState fromState:(TYVideoPlayerState)fromState
{
    switch (toState) {
        case TYVideoPlayerStateContentReadyToPlay:
            //[videoPlayer seekToLastWatchTime];
            [videoPlayer play];
            break;
            
        default:
            break;
    }
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
