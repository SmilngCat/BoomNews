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

- (void)requestWithURLString:(NSString *)urlString
						type:(BNSHTTPRequestResourceType)type
				  completion:(RequestBlock)completion {
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
													   timeoutInterval:5.f];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		if (error) {
			NSLog(@"%@", error.localizedDescription);
		}else {
			NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
			
			NSString *key = [urlString substringWithRange:NSMakeRange(35, 14)];
			NSArray *array = dic[key];
			NSMutableArray *datas = [[NSMutableArray alloc] init];
			for (NSDictionary *dic in array) {
				NewsModel *model = [NewsModel modelWithDictionary:dic];
				[datas addObject:model];
			}
			
			!completion ?: completion(datas);
			[datas release];
		}
	}];
	
}

#pragma mark - 处理数据，生成Model对象

//- (NSArray *)handleData:(NSData *)data type:(BNSHTTPRequestResourceType)type{
//	
//	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//	NSArray *array = nil;
//	switch (type) {
//		case BNSHTTPRequestResourceTypeEntertainmentOfNews: {
//			array = dic[@"T1348648517839"];
//			break;
//		}
//		case BNSHTTPRequestResourceTypeSportsOfNews: {
//			array = dic[@"T1348649079062"];
//			break;
//		}
//		case BNSHTTPRequestResourceTypeGameOfNews: {
//			array = dic[@"T1348654151579"];
//			break;
//		}
//		case BNSHTTPRequestResourceTypePolicyOfNews: {
//			array = dic[@"T1414142214384"];
//			break;
//		}
//		case BNSHTTPRequestResourceTypeTechnologyOfNews: {
//			array = dic[@"T1348649580692"];
//			break;
//		}
//	}
//	NSString *key =
//	for (NSDictionary *dic in array) {
//		Model *model = [[Model alloc]init];
//		[model setValuesForKeysWithDictionary:dic];
//		[_datas addObject:model];
//		[model release];
//	}
//	
//	return _datas;
//}


@end
