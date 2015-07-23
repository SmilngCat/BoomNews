//
//  BNSMineView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineView.h"
#import "BNSMineImageView.h"

#import "BNSMineViewController.h"
#import "BNSMineDetailedViewController.h"


@interface BNSMineView () <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray *datas;

@property (retain, nonatomic) BNSMineImageView *avatarImageView;
@property (retain, nonatomic) UITableView *settingTableView;
@end

@implementation BNSMineView

#pragma mark - BNSMineView Lifecycle

- (void)dealloc {
	
	[_datas release];
	
	[_avatarImageView release];
	[_settingTableView release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self loadData];
		[self buildLayout];
	}
	return self;
}

#pragma mark - Private

- (void)loadData {
	self.datas = [NSMutableArray array];
	
	MineModel *settingModel = [MineModel modelWithImage:@"setting" title:@"设置"];
	MineModel *storeModel = [MineModel modelWithImage:@"store" title:@"收藏"];
	MineModel *betaModel = [MineModel modelWithImage:@"beta" title:@"版本信息"];
	
	[_datas addObject:settingModel];
	[_datas addObject:storeModel];
	[_datas addObject:betaModel];
}

#pragma mark - Layout

- (void)buildLayout {
	[self addSubview:self.avatarImageView];
	[self addSubview:self.settingTableView];
	
	CGFloat tabBarHeight = [[NSUserDefaults standardUserDefaults] floatForKey:@"tabBarHeight"];
	UIView *view = self;
	NSDictionary *views = NSDictionaryOfVariableBindings(view,
														 _avatarImageView,
														_settingTableView);
	NSDictionary *metrics = @{@"imageViewHeight" : @300,
							  @"tableViewHeight" : @200,
							  @"tabBarHeight" : @(tabBarHeight)};
	
	//imageview的宽度
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_avatarImageView]|"
																 options:0
																 metrics:metrics
																   views:views]];
	
	//tableView的宽度
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_settingTableView]|"
																 options:0
																 metrics:metrics
																   views:views]];
	//tableView的高度
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_avatarImageView(<=imageViewHeight)]-20-[_settingTableView(tableViewHeight)]-tabBarHeight@249-|"
																 options:0
																 metrics:metrics
																   views:views]];
	
}


#pragma mark - Lazy loading

- (BNSMineImageView *)avatarImageView {
	if (!_avatarImageView) {
		_avatarImageView = [[BNSMineImageView alloc] init];
		_avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _avatarImageView;
}

- (UITableView *)settingTableView {
	if (!_settingTableView) {
		_settingTableView = [[UITableView alloc] init];
		_settingTableView.dataSource = self;
		_settingTableView.delegate = self;
		[_settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SETTING"];
		
		//隐藏多余的cell
		UIView *footerView = [[[UIView alloc] init] autorelease];
		footerView.backgroundColor = [UIColor clearColor];
		_settingTableView.tableFooterView = footerView;
		
		_settingTableView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _settingTableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	MineModel *model = _datas[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTING" forIndexPath:indexPath];
	[cell prepareForReuse];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.imageView.image = [UIImage imageNamed:model.image];
	cell.textLabel.text = model.title;
	
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
	
	BNSMineDetailedViewController *detailedViewController = [[[BNSMineDetailedViewController alloc] init] autorelease];
	NSMutableArray *datas = [NSMutableArray array];
	NSUInteger index = 0;
	
	switch (indexPath.row) {
		case 0: {
			[datas addObject:@"字体设置"];
			[datas addObject:@"夜间模式"];
			[datas addObject:@"清理缓存"];
			index = 0;
			break;
		}
		case 1: {
			[datas addObject:@"文章"];
			[datas addObject:@"图片"];
			index = 1;
			break;
		}
		case 2: {
			[datas addObject:@"版本号"];
			[datas addObject:@"关于我们"];
			index = 2;
			break;
		}
	}
	
	detailedViewController.index = index;
	detailedViewController.datas = datas;
	
	[self.viewController.navigationController pushViewController:detailedViewController animated:YES];
	

}

@end
