//
//  BNSWaitingViewController.m
//  BoomNews
//
//  Created by jsix lei on 15/7/24.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSWaitingViewController.h"

@interface BNSWaitingViewController ()

@property (retain, nonatomic) NSTimer *timer;
@property (retain, nonatomic) UIImageView *waitingImageView;
@end

@implementation BNSWaitingViewController

- (void)dealloc {
	
	[_timer release];
	[_waitingImageView release];
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	//返回按钮
//	UIToolbar *toolBar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)] autorelease];
//	
//	UIBarButtonItem *spaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
//	UIBarButtonItem *doneItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back:)] autorelease];
//	toolBar.items = @[spaceItem, doneItem];
//	
//	[self.view addSubview:toolBar];
	
	self.view.backgroundColor = [UIColor clearColor];
	self.waitingImageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
	_waitingImageView.contentMode = UIViewContentModeCenter;
	_waitingImageView.image = [UIImage imageNamed:@"waiting"];
	[self.view addSubview:_waitingImageView];
	
	
	 self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timer:) userInfo:nil repeats:YES];
	[_timer fire];
}


#pragma mark - Actions

- (void)back:(id)sender {
	[_timer invalidate];
	[self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)timer:(NSTimer *)timer {
	_waitingImageView.transform = CGAffineTransformRotate(_waitingImageView.transform, M_PI);
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
