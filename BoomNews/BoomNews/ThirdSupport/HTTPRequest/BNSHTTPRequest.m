//
//  BNSHTTPRequest.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSHTTPRequest.h"


static BNSHTTPRequest *sharedRequest = nil;

@implementation BNSHTTPRequest

- (void)dealloc {
	
	[super dealloc];
}

#pragma mark - singleton

+ (instancetype)sharedHTTPRequest {
	
	if (!sharedRequest) {
		sharedRequest = [[BNSHTTPRequest alloc] init];
	}
	return sharedRequest;
}

- (instancetype)allocWithZone:(NSZone *)zone {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedRequest = [super allocWithZone:zone];
	});
	return sharedRequest;
}

#pragma mark - 请求数据

- (BOOL)requestWithURLString:(NSString *)urlString
						type:(BNSHTTPRequestResourceType)type
				  completion:(RequestBlock)completion {
	
	__block BOOL result = NO;
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
													   timeoutInterval:10.f];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		if (error) {
			result = NO;
			NSLog(@"%@", error.localizedDescription);
		}else {
			result = YES;
			NSArray *datas = nil;
			if (type == BNSHTTPRequestResourceTypeVideo) {
				datas = [self handleVideoData:data urlString:urlString];
			}else {
				datas = [self handleNewsData:data urlString:urlString];
			}

			!completion ?: completion(datas);
		}
	}];
	return result;
}

#pragma mark - 处理数据，生成Model对象

- (NSArray *)handleNewsData:(NSData *)data urlString:(NSString *)urlString{
	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	
	NSString *key = [urlString substringWithRange:NSMakeRange(35, 14)];
	
	NSArray *array = dic[key];
	NSMutableArray *datas = [[[NSMutableArray alloc] init] autorelease];
	for (NSDictionary *dic in array) {
        if (![dic[@"skipType"] isEqualToString:@"live"]) {
            NewsModel *model = [NewsModel modelWithDictionary:dic];
            [datas addObject:model];
        }

	}

	return [datas.copy autorelease];
}

- (NSArray *)handleVideoData:(NSData *)data urlString:(NSString *)urlString {
	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	
	NSString *key = [urlString substringWithRange:NSMakeRange(33, 9)];
	
	NSArray *array = dic[key];
	NSMutableArray *datas = [[[NSMutableArray alloc] init] autorelease];
	for (NSDictionary *dic in array) {
		VideoModel *model = [VideoModel modelWithDictionary:dic];
		[datas addObject:model];
	}
	
	return [datas.copy autorelease];
}

@end
