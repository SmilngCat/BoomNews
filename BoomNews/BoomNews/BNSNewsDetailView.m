//
//  BNSNewsDetailView.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsDetailView.h"

@implementation BNSNewsDetailView


- (void)dealloc
{
    [_titleLabel release];
    [_digestLabel release];
    [_picSumLabel release];
    [super dealloc];
}

- (CGFloat)getStringHeightBasyFont:(CGFloat)font width:(CGFloat)width string:(NSString *)string{
    //计算高度的方法,矩形化后捕捉宽和高
    CGRect contentRect = [string boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return contentRect.size.height;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        self.digestLabel = [[UILabel alloc]init];
        [self addSubview:self.digestLabel];
        self.digestLabel.font = [UIFont systemFontOfSize:14];
        self.digestLabel.numberOfLines = 0;
        self.digestLabel.textColor = [UIColor whiteColor];
        
        
        
        
        self.picSumLabel = [[UILabel alloc]init];
        [self addSubview:self.picSumLabel];
        self.picSumLabel.textColor = [UIColor whiteColor];
        
        

        
        
    }


    return self;

}


- (void)layoutSubviews {


    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    
    
    self.digestLabel.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height - 20);
    
    self.picSumLabel.frame = CGRectMake(self.frame.size.width - 45, 0, 50, 20);
    
    CGFloat height = [self getStringHeightBasyFont:14 width:self.frame.size.width string:self.model.desc];
    
    self.digestLabel.frame = CGRectMake(0, 20, self.frame.size.width, height);
    
    self.contentSize = CGSizeMake(self.bounds.size.width, height + 20);
    
}

- (void)setModel:(BNSDetailModel *)model {

    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.titleLabel.text = model.setname;
    
    self.picSumLabel.text = [NSString stringWithFormat:@"%d/%@", 1 ,model.imgsum];

    

    
    

}




@end
