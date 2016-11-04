//
//  TravelingTipsCell.m
//  GlobalTravel
//
//  Created by john.zhang on 16/11/1.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "TravelingTipsCell.h"

@implementation TravelingTipsCell

- (void)awakeFromNib {


}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


        self.imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.titleText = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleText];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    
    //设置圆角
            self.imgView.layer.cornerRadius =self.frame.size.width/20;
            self.imgView.layer.masksToBounds=YES;
            self.imgView.clipsToBounds = YES;
    CGFloat w = self.frame.size.width;
    CGFloat h =self.frame.size.height;
    self.titleText.backgroundColor = [UIColor lightGrayColor];
    self.titleText.alpha = 0.8;
    self.titleText.frame = CGRectMake(5, h*9/10-25, w-10, 25);
    self.imgView.frame = CGRectMake(5,0, w-10, h*9/10);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
