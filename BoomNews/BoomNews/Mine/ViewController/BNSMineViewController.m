//
//  AccountViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineViewController.h"
#import "BNSMineView.h"

@interface BNSMineViewController ()

@end

@implementation BNSMineViewController

#pragma mark - BNSMineViewController Lifecycle

- (void)dealloc {
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	BNSMineView *mineView = [[[BNSMineView alloc] initWithFrame:self.view.bounds] autorelease];
	mineView.viewController = self;
	
	[self.view addSubview:mineView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	//隐藏导航栏
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	//显示导航栏
	[self.navigationController setNavigationBarHidden:NO animated:NO];
}


@end
