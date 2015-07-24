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
    [_model release];
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
        
    
        self.titleLabel = [[[UILabel alloc]init] autorelease];
        [self addSubview:_titleLabel];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        
        self.digestLabel = [[[UILabel alloc]init] autorelease];
        [self addSubview:_digestLabel];
        self.digestLabel.font = [UIFont systemFontOfSize:14];
        self.digestLabel.textColor = [UIColor whiteColor];
        self.digestLabel.numberOfLines = 0;
        self.digestLabel.textAlignment = NSTextAlignmentJustified;
        
        
        self.picSumLabel = [[[UILabel alloc]init] autorelease];
        [self addSubview:_picSumLabel];
        self.picSumLabel.textColor = [UIColor whiteColor];
        
        
        

        
        
    }


    return self;

}


- (void)layoutSubviews {


    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width - 50, 20);
    
    
    
    self.picSumLabel.frame = CGRectMake(self.frame.size.width - 45, 0, 50, 20);
    

    
    
    
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
