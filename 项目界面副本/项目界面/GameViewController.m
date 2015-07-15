//
//  GameViewController.m
//  项目界面
//
//  Created by 邵垚 on 15/7/13.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//


#import "GameViewController.h"
#import "GameTableViewCell.h"
#import "GameMessage.h"
#import "GameTableViewCell2.h"
#import "GameDetailViewController.h"
#define WINTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define URLSTR @"http://c.m.163.com/nc/article/list/T1348654151579/0-20.html"
@interface GameViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain) NSArray *datas;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, WINTH, 64)];
    toolBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:toolBar];
    [toolBar release];
    
    [self loadTableView];
    [self loadData];
    [self loadScrollView];
    
    // Do any additional setup after loading the view.
}


- (void)loadData{

    [[GameMessage shareGameMessageManager] requestData:URLSTR completion:^(id array) {
        self.datas = [array retain];
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
        });
    }];



}



- (void)loadScrollView{

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WINTH, 30)];
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollView];
    [scrollView release];

    UIView *zhanweiImage = [[UIView alloc]initWithFrame:CGRectMake(0, 94, WINTH, 64 * 3.5)];
    zhanweiImage.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:zhanweiImage];
    [zhanweiImage release];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 94 + 64*3.5, WINTH, 30)];
    titleLable.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleLable];
    [titleLable release];

}

- (void)loadTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 124 + 64*3.5, WINTH, HEIGHT - 104 + 64*3.5) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 75;

//    if ([GameTableViewCell class]) {
    [self.tableView registerClass:[GameTableViewCell2 class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[GameTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
//    } else {
//        [self.tableView registerClass:[GameTableViewCell2 class] forCellReuseIdentifier:@"cell"];
//    }
    
    
    //[self.tableView release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    


    Model *model = [GameMessage shareGameMessageManager].dataArray[indexPath.row];
    if (!model.imgextraArray) {
       GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        cell.cellModel = [GameMessage shareGameMessageManager].dataArray[indexPath.row];
        return cell;
    }else {
       GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
       cell.cellModel = [GameMessage shareGameMessageManager].dataArray[indexPath.row];
        return cell;
    }

    

    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [GameMessage shareGameMessageManager].dataArray.count;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    GameDetailViewController *detailView = [[GameDetailViewController alloc]init];
//    [self presentViewController:detailView animated:YES completion:^{
//        
//    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
