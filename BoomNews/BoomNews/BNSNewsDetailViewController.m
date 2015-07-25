//
//  BNSNewsDetailViewController.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/21.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsDetailViewController.h"
//普通界面网址
#define URL @"http://c.3g.163.com/nc/article/"
#define URL1 @"/full.html"
//照片界面网址
#define DETAILURL @"http://c.3g.163.com/photo/api/set/%@/%@.json"

//特殊界面网址
#define SPECIALURL @"http://c.3g.163.com/nc/%@/%@.html"

#import "Message.h"
#import "UIImageView+WebCache.h"
#import "BNSView.h"
#import "BNSScrollView.h"
#import "BNSScrollContentView.h"


#import "BNSNewsDetailView.h"
#import "BNSDetailModel.h"
#import "BNSNewsDetailWebView.h"

//本地化存储

#import "DataMessageBaseManaher.h"
#import "BNSMineModel.h"

@interface BNSNewsDetailViewController ()<BNSScrollViewDelegate, UIWebViewDelegate>

@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *detailArray;
@property (nonatomic, retain)NSMutableArray *noteArray;

@property (nonatomic, assign)NSInteger index;


@property (nonatomic, retain)BNSView *bnsView;

@property (nonatomic, retain)BNSNewsDetailView *detailView;
@property (nonatomic, retain)BNSNewsDetailWebView *detailWebView;

@property (nonatomic, assign)NSInteger i;
@property (nonatomic, assign)NSInteger j;
@property (nonatomic, retain)UIButton *_rightButton;
@end

@implementation BNSNewsDetailViewController
- (void)dealloc
{
    [_newsModel release];
    [_model release];
    [_detailView release];
    [_detailWebView release];
    [_webModel release];
    [_bnsView release];
    [_dataArray release];
    [_detailArray release];
    [_noteArray release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self._rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self._rightButton.frame = CGRectMake(0, 0, 60, 40);
    [self._rightButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self._rightButton];
    [self._rightButton setImage:[UIImage imageNamed:@"iconfont-shoucangjia-2"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = _rightBarButton;
    
    [self loadData];
    
    
    [_rightBarButton release];
}

- (void)collectAction:(UIButton *)sender {
    
    if (!self._rightButton.selected) {
        DataMessageBaseManaher *manager = [DataMessageBaseManaher shareDataBaseManager];
        [manager openDB];
        [manager createTable];
        [manager insertMessage:self.newsModel];
        UIAlertView *collectView = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [collectView show];
        self._rightButton.selected = YES;
    } else {
        UIAlertView *collectView = [[UIAlertView alloc] initWithTitle:@"已经收藏" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [collectView show];
    
    }
    
    

    
    

    

    

    
    
    
    
    
}

- (void)loadWebView:(BNSDetailWebModel *)model {
    
    self.detailWebView = [[[BNSNewsDetailWebView alloc]initWithFrame:self.view.frame] autorelease];
	_detailWebView.delegate = self;
    [self.view addSubview:_detailWebView];
    [self.detailWebView getThml:model];
	
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSDictionary *fontDic = [[NSUserDefaults standardUserDefaults] objectForMutableKey:@"TintFont"];
//	UIFont *currentFont = [UIFont fontWithName:fontDic[@"fontName"] size:[fontDic[@"fontSize"] integerValue]];
	NSString *fontSize = fontDic[@"fontSize"];
	
	NSString *jsString = [[[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f", fontSize.floatValue] autorelease];
//	NSString *jsString2 = [[[NSString alloc] initWithFormat:@"document.body.style.fontFamily=%@", currentFont.familyName] autorelease];
	[webView stringByEvaluatingJavaScriptFromString:jsString];
//	[webView stringByEvaluatingJavaScriptFromString:jsString2];
}

- (void)loadData {
    
    self.dataArray = [NSMutableArray array];
    self.detailArray = [NSMutableArray array];
    self.noteArray = [NSMutableArray array];
 

    
    //NSLog(@"%@", self.model.imgsrc);
    if (self.newsModel.skipID && [self.newsModel.skipType isEqualToString:@"photoset"]) {
        NSString *skipID1 = [self.newsModel.skipID substringWithRange:NSMakeRange(4, 4)];
        NSString *skipID2 = [self.newsModel.skipID substringFromIndex:9];
    __block typeof(self)weakSelf = self;
    [Message recivedDataWithURLString:[NSString stringWithFormat:DETAILURL, skipID1,skipID2] method:@"GET" body:nil Block:^(id object) {
        
        NSDictionary *dic = (NSDictionary *)object;
        
        self.model = [[[BNSDetailModel alloc]init] autorelease];

        [_model setValuesForKeysWithDictionary:dic];
        
        NSArray *array = dic[@"photos"];
        
        for (NSDictionary *dic in array) {

            self.model.imgurl = dic[@"imgurl"];
            self.model.imgtitle = dic[@"imgtitle"];
            self.model.note = dic[@"note"];
            
            
            [weakSelf.detailArray addObject:self.model.imgtitle];
            [weakSelf.dataArray addObject:self.model.imgurl];
            [weakSelf.noteArray addObject:self.model.note];
            
        }
        [self loadImageView];
        [self loadDetailView];
        
        
    }];
    
    } else {
    [Message recivedDataWithURLString:[NSString stringWithFormat:@"%@%@%@", URL, self.newsModel.docid, URL1] method:@"GET" body:nil Block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSArray *array = [dic allKeys];
        NSDictionary *tempDic = [dic objectForKey:array[0]];
        BNSDetailWebModel *model = [[[BNSDetailWebModel alloc]init]autorelease];
        self.webModel = model;
        [model setValuesForKeysWithDictionary:tempDic];
        [self loadWebView:model];
        }];
    }
    
}

- (void)loadImageView {


    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = self.view.frame;
    [self.view addSubview:effectView];
    [effectView release];

    self.bnsView = [[[BNSView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)] autorelease];
    //self.bnsView.center = self.view.center;
    self.bnsView.scrollView.contentView.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bnsView.scrollView.contentView.middleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bnsView.scrollView.contentView.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bnsView.scrollView.showsHorizontalScrollIndicator = NO;
    self.bnsView.bnsScrollDelegate = self;
    [self.view addSubview:self.bnsView];
    self.bnsView.images = self.dataArray;
    [self.bnsView bns_ConfigureScrollViewAtIndex:0 count:self.dataArray.count];
    
    _i = 2;
    _j = 1;

    
}

# pragma mark ------------- 底部文字和数字改变
- (void)changeIndex {
    if ([self.detailArray[1] isEqualToString:@""]) {
        self.detailView.digestLabel.text = self.noteArray[1];
        CGFloat height = [self.detailView getStringHeightBasyFont:14 width:self.detailView.frame.size.width string:self.noteArray[1]];
        self.detailView.digestLabel.frame = CGRectMake(0, 20, self.detailView.frame.size.width, height);
        self.detailView.contentSize = CGSizeMake(0, height + 20);
    } else {
        self.detailView.digestLabel.text = self.detailArray[1];
        CGFloat height = [self.detailView getStringHeightBasyFont:14 width:self.detailView.frame.size.width string:self.detailArray[1]];
        self.detailView.digestLabel.frame = CGRectMake(0, 20, self.detailView.frame.size.width, height);
        self.detailView.contentSize = CGSizeMake(0, height + 20);
    }

    self.detailView.picSumLabel.text = [NSString stringWithFormat:@"%ld/%@", _i, self.model.imgsum];
    
    NSInteger imgsum = [self.model.imgsum integerValue];
    
    if (self.bnsView.scrollView.contentOffset.x == 2 * self.view.frame.size.width ) {
        // 底部数字改变
        _i ++;
        if (_i > imgsum) {
            _i = 1;
        }
        self.detailView.picSumLabel.text = [NSString stringWithFormat:@"%ld/%@", _i, self.model.imgsum];
        
        // 底部文字改变
        _j ++;
        if (_j > self.noteArray.count - 1) {
            _j = 0;
        }
        [self getDetailViewContentSize];
    } else if (self.bnsView.scrollView.contentOffset.x == 0) {

        // 底部数字改变
        _i --;
        if (_i < 1) {
            
            _i = imgsum;
        }
        self.detailView.picSumLabel.text = [NSString stringWithFormat:@"%ld/%@", _i, self.model.imgsum];
        // 底部文字改变
        _j --;
        if (_j < 0) {
            _j = self.detailArray.count - 1;
        }
        [self getDetailViewContentSize];
        
    }
    
}

- (void)getDetailViewContentSize {

    if ([self.detailArray[_j] isEqualToString:@""]) {
        self.detailView.digestLabel.text = self.noteArray[_j];
        self.detailView.digestLabel.text = self.noteArray[_j];
        CGFloat height = [self.detailView getStringHeightBasyFont:14 width:self.detailView.frame.size.width string:self.noteArray[_j]];
        self.detailView.digestLabel.frame = CGRectMake(0, 20, self.detailView.frame.size.width, height);
        self.detailView.contentSize = CGSizeMake(0, height + 20);
    } else {
        self.detailView.digestLabel.text = self.detailArray[_j];
        self.detailView.digestLabel.text = self.detailArray[_j];
        CGFloat height = [self.detailView getStringHeightBasyFont:14 width:self.detailView.frame.size.width string:self.detailArray[_j]];
        self.detailView.digestLabel.frame = CGRectMake(0, 20, self.detailView.frame.size.width, height);
        self.detailView.contentSize = CGSizeMake(0, height + 20);
    }


}


- (void)loadDetailView {
    
    self.detailView = [[[BNSNewsDetailView alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height - self.view.frame.size.height/6, self.view.frame.size.width - 10, self.view.frame.size.height/4 - 80)] autorelease];
    self.detailView.model = self.model;
    if ([self.detailArray[0] isEqualToString:@""]) {
        self.detailView.digestLabel.text = self.noteArray[0];
        CGFloat height = [self.detailView getStringHeightBasyFont:14 width:self.detailView.frame.size.width string:self.noteArray[0]];
        self.detailView.digestLabel.frame = CGRectMake(0, 20, self.detailView.frame.size.width, height);
        self.detailView.contentSize = CGSizeMake(0, height + 20);
    } else {
        self.detailView.digestLabel.text = self.detailArray[0];
        CGFloat height = [self.detailView getStringHeightBasyFont:14 width:self.detailView.frame.size.width string:self.detailArray[0]];
        self.detailView.digestLabel.frame = CGRectMake(0, 20, self.detailView.frame.size.width, height);
        self.detailView.contentSize = CGSizeMake(0, height + 20);
    }
    [self.view addSubview:self.detailView];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
