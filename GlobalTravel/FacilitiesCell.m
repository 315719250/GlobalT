//
//  FacilitiesCell.m
//  GlobalTravel
//
//  Created by lanou on 16/11/2.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "FacilitiesCell.h"

@implementation FacilitiesCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0.466 green:0.476 blue:0.667 alpha:1.000];
    self.contenLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.contenLabel.font = [UIFont systemFontOfSize:12];
        self.contenLabel.numberOfLines = 0;
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview: self.contenLabel];
    }
    return self;
    
}
-(void)layoutSubviews
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.headerImage.frame = CGRectMake(5, 5, w-10, h-40);
    self.titleLabel.frame = CGRectMake(5, 5, w-10, 20);
    self.contenLabel.frame = CGRectMake(5, h-40, w-10, 40);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
