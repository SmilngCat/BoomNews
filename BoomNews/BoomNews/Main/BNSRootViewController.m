//
//  RootViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/15.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSRootViewController.h"

@interface BNSRootViewController ()

@end

@implementation BNSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
	return YES;
}

//只支持竖屏
- (NSUInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
