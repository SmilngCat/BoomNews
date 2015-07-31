//
//  VideoViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/8.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSVideoViewController.h"
#import "BNSVideoTableView.h"

@interface BNSVideoViewController ()

@property (copy, nonatomic) NSString *urlString;
@property (retain, nonatomic) BNSVideoTableView *videoTableView;
@end

@implementation BNSVideoViewController

#pragma mark - VideoViewController Lifecycle

- (void)dealloc {
	
	[_videoTableView release];
	[_urlString release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self loadData];
	[self loadUI];
}

- (void)loadData {
	self.urlString = @"http://c.3g.163.com/nc/video/list/V9LG4B3A0/y";
}

#pragma mark - Layout

- (void)loadUI {
	CGFloat tabBarHeight = [[NSUserDefaults standardUserDefaults] floatForKey:@"tabBarHeight"];
	CGFloat height = CGRectGetHeight(self.view.bounds) - 64  - tabBarHeight;
	CGFloat width = CGRectGetWidth(self.view.bounds);
	
	self.videoTableView = [[[BNSVideoTableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain] autorelease];
	_videoTableView.urlString = _urlString;
	_videoTableView.viewController = self;
	[self.view addSubview:_videoTableView];
	
	self.modalPresentationStyle = UIModalPresentationFullScreen;
	
	[_videoTableView headerBeginRefreshing];
	
//	[_videoTableView bns_LoadData:BNSHTTPRequestResourceTypeVideo];
}



@end
