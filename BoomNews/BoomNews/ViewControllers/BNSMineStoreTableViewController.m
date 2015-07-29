//
//  BNSMineStoreTableViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineStoreTableViewController.h"
#import "BNSNewsDetailViewController.h"
#import "DataMessageBaseManaher.h"
@interface BNSMineStoreTableViewController ()

@end

@implementation BNSMineStoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     UIBarButtonItem *editBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editbtnClick)];
    
    self.navigationItem.rightBarButtonItem = editBtn;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    BNSNewsDetailViewController *detailVC = [[BNSNewsDetailViewController alloc] init];
    
    detailVC.newsModel = self.newsModelArr[indexPath.row];
    
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [detailVC release];
    
}


- (void)editbtnClick
{
    if ([self.navigationItem.rightBarButtonItem.title isEqual: @"编辑"])
    {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [self setEditing:YES animated:YES];
        
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self setEditing:NO animated:YES];
        
    }
}

#pragma mark -------- 删除方法


- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return YES;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return UITableViewCellEditingStyleDelete;
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DataMessageBaseManaher *manager = [DataMessageBaseManaher shareDataBaseManager];
    [manager openDB];
    
    [manager deleteWithMessage:[self.newsModelArr[indexPath.row] title]];
    
    [self.datas removeObjectAtIndex:indexPath.row];
	[self.newsModelArr removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    return @"删除";

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
