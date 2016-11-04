//
//  CollectingVC.m
//  GlobalTravel
//
//  Created by john.zhang on 16/10/31.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "CollectingVC.h"
#import "ZZGallerySliderCell.h"
#import "ZZGallerySliderLayout.h"
#import "macro.h"
#import "TipsCollectingVC.h"
#import "HealthCollectingVC.h"
#import "FacilitiesCollectingVC.h"
#import "HikingCollectingVC.h"
@interface CollectingVC ()<ZZGallerySliderCellDelegate, ZZGallerySliderLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *galleryCollectionView;
    NSArray *dataArray;
    NSArray *titleArr;
}
@end

@implementation CollectingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];



    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"收藏夹";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    

    [self initData];
    [self initCollectionView];

}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initData
{
    dataArray =@[@"Hot.jpg",@"overseas.jpg",@"island.jpg",@"southeastAsia.jpg"];
    
    titleArr = @[@"旅行攻略",@"旅行健康",@"旅行工具",@"徒步旅行"];
}
-(void)initCollectionView
{
    ZZGallerySliderLayout *layout = [[ZZGallerySliderLayout alloc] init];
    //可滑动距离
    [layout setContentSize:4];
    
    galleryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CELL_WIDTH,[UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    //设置背景图片
    UIImageView *imgView= [[UIImageView alloc]initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"background.jpg"];
    galleryCollectionView.backgroundView = imgView;
    
    [galleryCollectionView registerClass:[ZZGallerySliderCell class] forCellWithReuseIdentifier:@"CELL"];
    galleryCollectionView.backgroundColor = [UIColor whiteColor];
    

    
    galleryCollectionView.delegate = self;
    galleryCollectionView.dataSource = self;
    [self.view addSubview:galleryCollectionView];
}

#pragma -mark UICollectionView 代理方法

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count+1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return CGSizeMake(CELL_WIDTH, HEADER_HEIGHT);
    }else if(indexPath.row == 1){
        return CGSizeMake(CELL_WIDTH, CELL_CURRHEIGHT);
    }else{
        return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZGallerySliderCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setIndex:indexPath.row];
    [cell reset];
    
    if(indexPath.row == 0){
        cell.imageView.image = nil;
    }else{
        if(indexPath.row == 1){
            [cell revisePositionAtFirstCell];
        }
        
                    [cell setNameLabel:titleArr[indexPath.row-1]];
//                    [cell setDescLabel:@""];
        UIImage *image = [UIImage imageNamed:[dataArray objectAtIndex:indexPath.row-1]];
        cell.imageView.image = image;
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {

        case 1:{
            TipsCollectingVC *vc = [[TipsCollectingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 2:{
            HealthCollectingVC *vc = [[HealthCollectingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"点击了第2个图片");

        }
            break;
        case 3:{
            FacilitiesCollectingVC *vc = [[FacilitiesCollectingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"点击了第3个图片");

        }
            break;
        case 4:{
            HikingCollectingVC *vc = [[HikingCollectingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"点击了第4个图片");
        }
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;

}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = YES;
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
