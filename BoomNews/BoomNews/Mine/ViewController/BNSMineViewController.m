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

#pragma mark - AccountViewController Lifecycle

- (void)dealloc {
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//隐藏导航栏
	self.navigationController.navigationBar.hidden = YES;

	BNSMineView *mineView = [[[BNSMineView alloc] initWithFrame:self.view.bounds] autorelease];
	mineView.viewController = self;
	
	[self.view addSubview:mineView];
}



@end
