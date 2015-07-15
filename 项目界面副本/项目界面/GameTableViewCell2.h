//
//  GameTableViewCell2.h
//  项目界面
//
//  Created by 邵垚 on 15/7/14.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "UIImageView+WebCache.h"
@interface GameTableViewCell2 : UITableViewCell

@property (nonatomic, retain)Model *cellModel;

@property (nonatomic, retain)UILabel *titleLabel;

@property (nonatomic, retain)UIImageView *imgsrcImageView;

@property (nonatomic, retain)UIImageView *imgextraImageView;

@property (nonatomic, retain)UIImageView *imgextraImageView2;

@end
