//
//  BNSNewsDetailViewController.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/21.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsDetailViewController.h"
#define URL @"http://c.3g.163.com/nc/article/"
#define URL1 @"/full.html"
#define DETAILURL @"http://c.3g.163.com/photo/api/set/%@/%@.json"
#import "Message.h"
#import "UIImageView+WebCache.h"
#import "BNSView.h"
#import "BNSScrollView.h"
#import "BNSScrollContentView.h"


#import "BNSNewsDetailView.h"
#import "BNSDetailModel.h"
@interface BNSNewsDetailViewController ()<BNSScrollViewDelegate>
@property (nonatomic, retain)UIWebView *webView;

@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *detailArray;
@property (nonatomic, retain)NSMutableArray *noteArray;

@property (nonatomic, assign)NSInteger index;


@property (nonatomic, retain)BNSView *bnsView;

@property (nonatomic, retain)BNSNewsDetailView *detailView;

@property (nonatomic, assign)NSInteger i;
@property (nonatomic, assign)NSInteger j;
@end

@implementation BNSNewsDetailViewController
- (void)dealloc
{
    [_model release];
    [_webView release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadUI];
    
    
}



- (void)loadUI {
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    [_webView release];
    
    
    
    
}


- (void)loadData {
    
    
    self.dataArray = [NSMutableArray array];
    self.detailArray = [NSMutableArray array];
    self.noteArray = [NSMutableArray array];
 
    NSString *skipID1 = [self.model.skipID substringWithRange:NSMakeRange(4, 4)];
    NSString *skipID2 = [self.model.skipID substringFromIndex:9];
    
    if (self.model.skipID) {
        
    
    self.dataArray = [NSMutableArray array];
        
    __block typeof(self)weakSelf = self;
    [Message recivedDataWithURLString:[NSString stringWithFormat:DETAILURL, skipID1,skipID2] method:@"GET" body:nil Block:^(id object) {
        
        NSDictionary *dic = (NSDictionary *)object;
        
        self.model = [[BNSDetailModel alloc]init];

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
        [_model release];
        
        
        
    }];
    
    } else {
    __block typeof(self) weakSelf = self;
    [Message recivedDataWithURLString:[NSString stringWithFormat:@"%@%@%@", URL, self.model.docid, URL1] method:@"GET" body:nil Block:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        NSDictionary *dic1 = [dic objectForKey:weakSelf.model.docid];
        NSString *bodyStr = [dic1 objectForKey:@"body"];
        [weakSelf.webView loadHTMLString:bodyStr baseURL:nil];
        
        
    }];
    }
    
}

- (void)loadImageView {


    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = self.view.frame;
    [self.view addSubview:effectView];
    [effectView release];

    self.bnsView = [[BNSView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
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
    } else {
        self.detailView.digestLabel.text = self.detailArray[1];
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
        if ([self.detailArray[_j] isEqualToString:@""]) {
            self.detailView.digestLabel.text = self.noteArray[_j];
        } else {
            self.detailView.digestLabel.text = self.detailArray[_j];
        }

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
        if ([self.detailArray[_j] isEqualToString:@""]) {
            self.detailView.digestLabel.text = self.noteArray[_j];
        } else {
            self.detailView.digestLabel.text = self.detailArray[_j];
        }

        
    }
    
}

- (void)loadDetailView {
    
    self.detailView = [[BNSNewsDetailView alloc]initWithFrame:CGRectMake(5, self.view.frame.size.height - self.view.frame.size.height/6, self.view.frame.size.width - 10, self.view.frame.size.height/4 - 80)];
    self.detailView.model = self.model;
    if ([self.detailArray[0] isEqualToString:@""]) {
        self.detailView.digestLabel.text = self.noteArray[0];
    } else {
        self.detailView.digestLabel.text = self.detailArray[0];
    }
    [self.view addSubview:self.detailView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end