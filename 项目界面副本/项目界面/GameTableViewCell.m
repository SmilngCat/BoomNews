//
//  GameTableViewCell.m
//  项目界面
//
//  Created by 邵垚 on 15/7/13.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "GameTableViewCell.h"
#define WINTH self.frame.size.width
#define HEIGHT self.frame.size.height
@implementation GameTableViewCell


- (void)dealloc
{
    [_titleLabel release];
    [_digestLabel release];
    [_imgsrcImageView release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        
        self.imgsrcImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgsrcImageView];
        
        self.digestLabel = [[UILabel alloc]init];
        self.digestLabel.font = [UIFont systemFontOfSize:14];
        self.digestLabel.numberOfLines = 0;
        self.digestLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.digestLabel];
    }

    return self;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.titleLabel.frame = CGRectMake(85, 5, WINTH - 90, 20);
    
    self.imgsrcImageView.frame = CGRectMake(5, 5, 75, 65);

    self.digestLabel.frame = CGRectMake(85, 35, WINTH - 90, 35);
}

- (void)setCellModel:(Model *)cellModel{

    if (_cellModel != cellModel) {
        [_cellModel release];
        _cellModel = [cellModel retain];
    }
    
    _titleLabel.text = self.cellModel.title;
    
    
    NSURL *url = [NSURL URLWithString:self.cellModel.imgsrc];
    [_imgsrcImageView sd_setImageWithURL:url];
    
    _digestLabel.text = self.cellModel.digest;
 
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
