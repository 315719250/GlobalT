//
//  RelexMomentCell.m
//  GlobalTravel
//
//  Created by lanou on 16/11/4.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "RelexMomentCell.h"

@implementation RelexMomentCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.firstImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.firstImage.layer.cornerRadius = self.frame.size.width/10;
        self.firstImage.layer.masksToBounds = YES;
        self.firstImage.clipsToBounds = YES;
        self.secondImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.firstImage];
        [self.contentView addSubview:self.secondImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}
-(void)layoutSubviews
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.firstImage.frame = CGRectMake(5, 5, w/5, w/5);
    self.secondImage.frame = CGRectMake(5, h/3, w-10, h-110);
    self.nameLabel.frame = CGRectMake(w/4, 5, w/2, h/5);
    self.titleLabel.frame = CGRectMake(5, h/5.5, w, h/5);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
