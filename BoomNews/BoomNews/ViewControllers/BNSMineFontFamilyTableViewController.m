//
//  BNSMineFontFamilyTableViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineFontFamilyTableViewController.h"

#import "BNSMineMenuViewController.h"

@implementation BNSMineFontFamilyTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	BNSMineMenuViewController *viewController = [[[BNSMineMenuViewController alloc] init] autorelease];
	__block typeof(viewController) weakViewController = viewController;

	NSString *familyName = self.datas[indexPath.row];
	viewController.datas = [UIFont fontNamesForFamilyName:familyName];
	viewController.index = 0;
	viewController.family = indexPath.row;
	
	viewController.then = ^(NSUInteger obj) {
		
		NSDictionary *fontDicOrigin = [[NSUserDefaults standardUserDefaults] objectForKey:@"TintFont"];
		
		NSMutableDictionary *fontDic = [NSMutableDictionary dictionary];
		fontDic[@"fontName"] = weakViewController.datas[obj];
		fontDic[@"fontSize"] = fontDicOrigin[@"fontSize"];
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TintFont"];
		[[NSUserDefaults standardUserDefaults] setObject:fontDic forKey:@"TintFont"];
		[[NSNotificationCenter defaultCenter] postNotificationName:kBNSTintFontChanged object:nil];
	};
	[self.navigationController pushViewController:viewController animated:YES];
}
@end
