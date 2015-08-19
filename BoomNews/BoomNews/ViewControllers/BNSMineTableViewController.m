//
//  BNSMineTableViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineTableViewController.h"
#import "BNSMineMenuViewController.h"

@interface BNSMineTableViewController ()

@end

@implementation BNSMineTableViewController

- (void)dealloc {
	
	[_datas release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//隐藏多余的cell
	UIView *footerView = [[[UIView alloc] init] autorelease];
	footerView.backgroundColor = [UIColor clearColor];
	self.tableView.tableFooterView = footerView;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MINECELL"];
	
	//自定义返回按钮
//	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
//	self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

#pragma mark - Actions

//- (void)back:(id)sender {
//	if (_hiddenNavigationBar) {
//		self.navigationController.navigationBar.hidden = YES;
//	}
//	[self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MINECELL" forIndexPath:indexPath];
    
    

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
	
	cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
