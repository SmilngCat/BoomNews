//
//  BNSMineDetailedViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineDetailedViewController.h"
#import "BNSMineFontTableViewController.h"

#import "BNSCacheManager.h"

@interface BNSMineDetailedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) UITableView *menuTableView;
@end

@implementation BNSMineDetailedViewController

#pragma mark - BNSMineDetailedViewController Lifecycle

- (void)dealloc {
	
	[_datas release];
 	[_menuTableView release];
	[super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	//显示导航栏
	self.navigationController.navigationBar.hidden = NO;

	[self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadUI {
	self.menuTableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
	_menuTableView.dataSource = self;
	_menuTableView.delegate = self;
	[_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MENU"];
	
	//隐藏多余的cell
	UIView *footerView = [[[UIView alloc] init] autorelease];
	footerView.backgroundColor = [UIColor clearColor];
	_menuTableView.tableFooterView = footerView;
	
	[self.view addSubview:_menuTableView];
	
	//自定义返回按钮
//	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
//	self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

#pragma mark - Actions

//- (void)back:(id)sender {
//	self.navigationController.navigationBar.hidden = YES;
//	[self.navigationController popViewControllerAnimated:YES];
//}

- (void)switchSelected:(UISwitch *)sender {

	UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	if (sender.isOn) {
		window.alpha = 0.5f;
	}else {
		window.alpha = 1.f;
	}
}

#pragma mark - Private

- (UITableViewCellAccessoryType)accessoryTypeWithIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCellAccessoryType type = UITableViewCellAccessoryNone;
	if (indexPath.row == 0) {
		type = UITableViewCellAccessoryDisclosureIndicator;
	}
	else {
		type = UITableViewCellAccessoryDisclosureIndicator;
	}
	return type;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *string = _datas[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MENU" forIndexPath:indexPath];
	[cell prepareForReuse];
	cell.textLabel.text = string;
	cell.accessoryType = [self accessoryTypeWithIndexPath:indexPath];
	
	if (indexPath.row == 1) {
		
		UISwitch *switchButton = [[[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 40)] autorelease];
		[switchButton addTarget:self action:@selector(switchSelected:) forControlEvents:UIControlEventValueChanged];
		[switchButton setOn:NO animated:YES];
		cell.accessoryView = switchButton;
		
	}else if (indexPath.row == 2) {
		
		NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
		//当前缓存大小
		CGFloat cacheSize = [[BNSCacheManager defaultManager] folderSizeAtPath:cachePath];
		
		UILabel *capacityLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)] autorelease];
		capacityLabel.textAlignment = NSTextAlignmentRight;
		capacityLabel.text = [NSString stringWithFormat:@"%.1fM", cacheSize];
		cell.accessoryView = capacityLabel;
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
	[self tableView:tableView handleSelectedAtIndexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView handleSelectedAtIndexPath:(NSIndexPath *)indexPath {

	//字体设置
	if (indexPath.row == 0) {

		BNSMineFontTableViewController *menuViewController = [[[BNSMineFontTableViewController alloc] init] autorelease];
		menuViewController.datas = [NSMutableArray array];
		[menuViewController.datas addObject:@"字体类型"];
		[menuViewController.datas addObject:@"字体大小"];
		[self.navigationController pushViewController:menuViewController animated:YES];
		
	//夜间模式
	}else if (indexPath.row == 1){
		
		
	//清理缓存
	}else if (indexPath.row == 2) {
		NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
		//清理当前缓存
		[[BNSCacheManager defaultManager] clearCache:cachePath];
		
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"是否清理缓存?" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			

			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			UILabel *accessoryLabel = (UILabel *)cell.accessoryView;
			accessoryLabel.text = @"0M";
		}];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
		
		[alertController addAction:cancelAction];
		[alertController addAction:confirmAction];
		
		[self presentViewController:alertController animated:YES completion:^{}];
	}
}


@end
