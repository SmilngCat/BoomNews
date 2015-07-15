//
//  GameTableViewCell2.m
//  项目界面
//
//  Created by 邵垚 on 15/7/14.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import "GameTableViewCell2.h"
#define WINTH self.frame.size.width
#define HEIGHT self.frame.size.height
@implementation GameTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc]init];
        //self.titleLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.imgsrcImageView = [[UIImageView  alloc]init];
        self.imgsrcImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imgsrcImageView];
        
        self.imgextraImageView = [[UIImageView alloc]init];
        //self.imgextraImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imgextraImageView];
        
        self.imgextraImageView2 = [[UIImageView alloc]init];
        //self.imgextraImageView2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imgextraImageView2];
    }


    return self;

}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.frame = CGRectMake(5, 5, WINTH, 20);
    
    self.imgsrcImageView.frame = CGRectMake(5, 25, WINTH / 3 - 10, 20);
    
    self.imgextraImageView.frame = CGRectMake(5 + WINTH / 3 - 5, 25, WINTH / 3 - 10, 20);
    
    self.imgextraImageView2.frame = CGRectMake(2 * WINTH / 3, 25, WINTH / 3 - 10, 20);


}

- (void)setCellModel:(Model *)cellModel{
    if (_cellModel != cellModel) {
        [_cellModel release];
        _cellModel = [cellModel retain];
    }

    self.titleLabel.text = cellModel.title;

    NSURL *imgsrcUrl = [NSURL URLWithString:cellModel.imgsrc];
    [self.imgsrcImageView sd_setImageWithURL:imgsrcUrl];


    NSURL *imgextraUrl1 = [NSURL URLWithString:[cellModel.imgextraArray[0] imgsrc]];
    [self.imgextraImageView sd_setImageWithURL:imgextraUrl1];
    
    NSURL *imgextraUrl2 = [NSURL URLWithString:[cellModel.imgextraArray[1] imgsrc]];
    [self.imgextraImageView2 sd_setImageWithURL:imgextraUrl2];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
