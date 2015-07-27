//
//  BNSMineFontTableViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineFontTableViewController.h"

#import "BNSMineMenuViewController.h"
#import "BNSMineFontFamilyTableViewController.h"

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

	if (indexPath.row == 0) {
		BNSMineFontFamilyTableViewController *viewController = [[[BNSMineFontFamilyTableViewController alloc] init] autorelease];
		viewController.datas = [NSMutableArray arrayWithArray:[UIFont familyNames]];
		[self.navigationController pushViewController:viewController animated:YES];
		
	}else {
		BNSMineMenuViewController *viewController = [[[BNSMineMenuViewController alloc] init] autorelease];
		__block typeof(viewController) weakViewController = viewController;
		viewController.datas = @[@"12", @"15", @"17"];
		viewController.index = 1;
		viewController.then = ^(NSUInteger obj) {
			
			NSDictionary *fontDicOrigin = [[NSUserDefaults standardUserDefaults] objectForMutableKey:@"TintFont"];
			NSString *fontName = [NSString stringWithString:fontDicOrigin[@"fontName"]];
			NSMutableDictionary *fontDic = [NSMutableDictionary dictionary];
			fontDic[@"fontName"] = fontName;
			fontDic[@"fontSize"] = weakViewController.datas[obj];
//			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TintFont"];
			[[NSUserDefaults standardUserDefaults] setObject:fontDic forMutableKey:@"TintFont"];
			[[NSNotificationCenter defaultCenter] postNotificationName:kBNSTintFontChanged object:nil];
		};
		[self.navigationController pushViewController:viewController animated:YES];
	}
	
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
