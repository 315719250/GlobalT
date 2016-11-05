//
//  HikingCell.m
//  GlobalTravel
//
//  Created by lanou on 16/11/2.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "HikingCell.h"

@implementation HikingCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.contextLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.contextLabel.numberOfLines = 0;
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.dateLabel.font = [UIFont systemFontOfSize:15];
        self.fromLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.fromLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.headerImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contextLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.fromLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    CGFloat w =self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.headerImage.frame = CGRectMake(5, 5, w/2.5, h-25);
    self.dateLabel.frame = CGRectMake(5, h-25, w/2.4, 25);
    self.titleLabel.frame = CGRectMake(w/2.4, 5, w/1.8, h/4);
    self.contextLabel.frame = CGRectMake(w/2.4, h/4, w/1.8, h/2);
    self.fromLabel.frame = CGRectMake(w/1.4, h-25, w/2, 30);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
