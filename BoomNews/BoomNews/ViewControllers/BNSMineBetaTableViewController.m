//
//  BNSMineBetaTableViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineBetaTableViewController.h"
#import "BNSMessageViewController.h"
@interface BNSMineBetaTableViewController ()

@end

@implementation BNSMineBetaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        BNSMessageViewController *messageVC = [[BNSMessageViewController alloc]init];
        [self.navigationController pushViewController:messageVC animated:YES];
        [messageVC release];
    } else {
        
        UIAlertView *ourMessageAlertView = [[UIAlertView alloc] initWithTitle:@"关于我们" message:@"本软件由雷亚东，李昊，邵垚联合开发，仅供阅读使用，请勿用于商业和非法途径，如产生法律问题与开发者无关" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [ourMessageAlertView show];
        [ourMessageAlertView release];
        
    }
    
    
}

@end
