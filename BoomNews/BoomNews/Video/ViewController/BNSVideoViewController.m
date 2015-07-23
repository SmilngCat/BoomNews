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
	self.urlString = @"http://c.m.163.com/nc/video/list/V9LG4B3A0/y";
}

#pragma mark - Layout

- (void)loadUI {
	self.videoTableView = [[[BNSVideoTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
	_videoTableView.urlString = _urlString;
	[self.view addSubview:_videoTableView];
	
	[_videoTableView headerBeginRefreshing];
	
//	[_videoTableView bns_LoadData:BNSHTTPRequestResourceTypeVideo];
}



@end
