//
//  BNSMessageViewController.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMessageViewController.h"

@interface BNSMessageViewController ()

@end

@implementation BNSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIImage *versionImage = [UIImage imageNamed:@"boom"];
    CGFloat imageViewHeight = versionImage.size.width / versionImage.size.height;
    UIImageView *versionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/4, self.view.frame.size.width/2, self.view.frame.size.width/2 / imageViewHeight)] ;
    versionImageView.image = versionImage;
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/4 + 10 + self.view.frame.size.width/2 / imageViewHeight, self.view.frame.size.width, 20)];
    versionLabel.text = @"BOOM新闻 Version 1.0.0";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    [self.view addSubview:versionImageView];
        
        
        
    [versionLabel release];
    [versionImageView release];
        

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
