//
//  BNSNewsDetailWebView.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSNewsDetailWebView.h"

@implementation BNSNewsDetailWebView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self doChangForColor1];
    }

    return self;

}


-(void)doChangForColor1
{
    NSString *str=[self restoreFromUserDefaults:@"day"];
    if ([str isEqualToString:@"YES"]) {
        self.scrollView.alpha=1;
        
    }
    else if ([str isEqualToString:@"NO"])
    {
        
        
        self.scrollView.alpha=0.6;
    }
    
    
}

#pragma -mark数据持久化
-(void)saveToUserDefaults:(NSString*)tosaveedString withKey:(NSString *)tosaveedKey
{
    NSUserDefaults * tmp = [NSUserDefaults standardUserDefaults];
    if (tmp) {
        [tmp setObject:tosaveedString forKey:tosaveedKey];
    }
}


-(NSString *)restoreFromUserDefaults:(NSString *)key
{
    NSString * rtn = nil;
    NSUserDefaults * tmp = [NSUserDefaults standardUserDefaults];
    if (tmp) {
        rtn = [tmp objectForKey:key];
    }
    return rtn;
}







-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (void)getThml:(BNSDetailWebModel *)detail
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html" ofType:@"txt"];
    NSMutableString *str = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"htmlCSS" ofType:@"css"];
    
    NSRange rangeOfCSSPath = [str rangeOfString:@"#CSSPath#"];
    
    [str replaceCharactersInRange:rangeOfCSSPath withString:cssPath];
    //取子串在父串中的位置及范围
    NSRange titleRange = [str rangeOfString:@"#title#"];
    
    [str replaceCharactersInRange:titleRange withString:detail.title];
    
    NSRange sourceRange = [str rangeOfString:@"#source#"];
    [str replaceCharactersInRange:sourceRange withString:detail.source];
    
    NSRange timeRange = [str rangeOfString:@"#time#"];
    [str replaceCharactersInRange:timeRange withString:detail.ptime];
    
    NSRange bodyRange = [str rangeOfString:@"#body#"];
    
    
    
    [str replaceCharactersInRange:bodyRange withString:detail.body];
    
    for (NSDictionary *dict in detail.img) {
        
        int a;
        int b;
        if (dict[@"pixel"] != nil) {
            NSArray *arr = [dict[@"pixel"] componentsSeparatedByString:@"*"];
            a = [arr[0] intValue];
            b = [arr[1] intValue];
        }else{
            a = 1;
            b = 1;
        }
        
        NSMutableString *imgHtml = [NSMutableString stringWithFormat:@"<img class=\"content-image\" src=\"%@\" alt=\"\" width = %@px height = %@px /><p style=\"font-size:14px\">%@</p>",[dict objectForKey:@"src"],[NSString stringWithFormat:@"%f",self.frame.size.width - 15],[NSString stringWithFormat:@"%f",(self.frame.size.width - 10)*b/a],[dict objectForKey:@"alt"]];
        
        NSRange rangeOfImg = [str rangeOfString:[dict objectForKey:@"ref"]];
        if (rangeOfImg.length != 0) {
            
            [str replaceCharactersInRange:rangeOfImg withString:imgHtml];
        }
    }
    [self loadHTMLString:str baseURL:nil];
    
    
    
    
}



@end
