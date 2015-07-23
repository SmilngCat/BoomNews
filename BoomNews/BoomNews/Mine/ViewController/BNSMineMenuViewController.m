//
//  BNSMineMenuViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineMenuViewController.h"

static NSUInteger row = 0;

@interface BNSMineMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView *listTableView;
@end

@implementation BNSMineMenuViewController

#pragma mark - BNSMineMenuViewController Lifecycle

- (void)dealloc {
	
	[_datas release];
	[_listTableView release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)loadUI {
	self.listTableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
	_listTableView.dataSource = self;
	_listTableView.delegate = self;
	[_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LIST"];
	
	//隐藏多余的cell
	UIView *footerView = [[[UIView alloc] init] autorelease];
	footerView.backgroundColor = [UIColor clearColor];
	_listTableView.tableFooterView = footerView;
	
	//自定义返回按钮
	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
	self.navigationItem.leftBarButtonItem = backBarButtonItem;
	
	[self.view addSubview:_listTableView];
}

#pragma mark - Actions

- (void)back:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *string = _datas[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LIST" forIndexPath:indexPath];
	[cell prepareForReuse];
	cell.textLabel.text = string;
	if (indexPath.row == row) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
	UITableViewCell *previousCell = [tableView cellForRowAtIndexPath:previousIndexPath];
	previousCell.accessoryType = UITableViewCellAccessoryNone;
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	row = indexPath.row;
}

@end