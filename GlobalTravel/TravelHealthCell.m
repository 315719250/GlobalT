//
//  TravelHealthCell.m
//  GlobalTravel
//
//  Created by lanou on 16/11/1.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "TravelHealthCell.h"

@implementation TravelHealthCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectZero];

//        设置圆角
        self.imgView.layer.cornerRadius =self.frame.size.width/20;
        self.imgView.layer.masksToBounds=YES;
        self.imgView.clipsToBounds = YES;
        
        self.titleText = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleText.font = [UIFont systemFontOfSize:20];
        self.titleText.numberOfLines = 0;
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleText];
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.imgView.frame = CGRectMake(5, 5, w/3, h-5);
    
    self.titleText.frame =CGRectMake(w/2.8, 0, w*2/3, h/2);
    self.dateLabel.frame = CGRectMake(w/2.8, h/2, w/2, h/2);
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
