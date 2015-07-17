//
//  BNSHTTPRequest.m
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSHTTPRequest.h"
#import "Model.h"

static BNSHTTPRequest *sharedRequest = nil;

@interface BNSHTTPRequest ()

@property (retain, nonatomic) NSOperationQueue *queue;
@property (retain, nonatomic) NSMutableArray *datas;
@end

@implementation BNSHTTPRequest

- (void)dealloc {
	
	[_datas release];
	[super dealloc];
}

#pragma mark - singleton

+ (instancetype)sharedHTTPRequest {
	
	if (!sharedRequest) {
		sharedRequest = [[BNSHTTPRequest alloc] init];
		sharedRequest.datas = [NSMutableArray array];
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
					httpBody:(NSData *)httpBody
				  completion:(RequestBlock)completion {
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	
	[_datas removeAllObjects];
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		
		NSArray *datas = [self handleData:data type:type];
		!completion ?: completion(datas);
		
	}];
	
}

#pragma mark - 处理数据，生成Model对象

- (NSArray *)handleData:(NSData *)data type:(BNSHTTPRequestResourceType)type{
	
	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	NSArray *array = nil;
	switch (type) {
		case BNSHTTPRequestResourceTypeEntertainmentOfNews: {
			array = dic[@"T1348648517839"];
			break;
		}
		case BNSHTTPRequestResourceTypeSportsOfNews: {
			array = dic[@"T1348649079062"];
			break;
		}
		case BNSHTTPRequestResourceTypeGameOfNews: {
			array = dic[@"T1348654151579"];
			break;
		}
		case BNSHTTPRequestResourceTypePolicyOfNews: {
			array = dic[@"T1414142214384"];
			break;
		}
		case BNSHTTPRequestResourceTypeTechnologyOfNews: {
			array = dic[@"T1348649580692"];
			break;
		}
	}
	
	for (NSDictionary *dic in array) {
		Model *model = [[Model alloc]init];
		[model setValuesForKeysWithDictionary:dic];
		[_datas addObject:model];
		[model release];
	}
	
	return _datas;
}


@end
