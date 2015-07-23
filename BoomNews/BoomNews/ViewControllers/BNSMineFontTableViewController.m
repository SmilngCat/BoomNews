//
//  BNSMineFontTableViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineFontTableViewController.h"
#import "BNSMineMenuViewController.h"

@interface BNSMineFontTableViewController ()

@end

@implementation BNSMineFontTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BNSMineMenuViewController *viewController = [[[BNSMineMenuViewController alloc] init] autorelease];
	__block typeof(viewController) weakViewController = viewController;
	
	if (indexPath.row == 0) {
		viewController.datas = @[@"AppleGothic", @"ArialMT", @"Arial-BoldMT", @"Arial-ItalicMT",@"Arial-BoldItalicMT", @"Courier", @"CourierNewPS-ItalicMT", @"GeezaPro"];
		viewController.index = 0;
		
		viewController.then = ^(NSUInteger obj) {
			
			NSDictionary *fontDicOrigin = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
			
			NSMutableDictionary *fontDic = [NSMutableDictionary dictionary];
			fontDic[@"fontName"] = weakViewController.datas[obj];
			fontDic[@"fontSize"] = fontDicOrigin[@"fontSize"];
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TintFont"];
			[[NSUserDefaults standardUserDefaults] setObject:fontDic forKey:@"TintFont"];
			[[NSNotificationCenter defaultCenter] postNotificationName:kBNSTintFontChanged object:nil];
		};
	}else {
		viewController.datas = @[@"12", @"15", @"17"];
		viewController.index = 1;
		viewController.then = ^(NSUInteger obj) {
			
			NSDictionary *fontDicOrigin = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
			NSString *fontName = [NSString stringWithString:fontDicOrigin[@"fontName"]];
			NSMutableDictionary *fontDic = [NSMutableDictionary dictionary];
			fontDic[@"fontName"] = fontName;
			fontDic[@"fontSize"] = weakViewController.datas[obj];
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TintFont"];
			[[NSUserDefaults standardUserDefaults] setObject:fontDic forKey:@"TintFont"];
			[[NSNotificationCenter defaultCenter] postNotificationName:kBNSTintFontChanged object:nil];
		};
	}
	[self.navigationController pushViewController:viewController animated:YES];
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
