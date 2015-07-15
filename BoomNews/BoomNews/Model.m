//
//  NewsListSingleImageCellModel.m
//  BoomNews
//
//  Created by jsix lei on 15/7/9.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "Model.h"

@implementation Model



+ (instancetype)modelWithProfile:(NSString *)profile
						   title:(NSString *)title
						  digest:(NSString *)digest
							 ima:(NSMutableArray *)ima{
	
	return [[[[self class] alloc] initWithProfile:profile
										   title:title
										  digest:digest
											 ima:ima] autorelease];
}

- (instancetype)initWithProfile:(NSString *)profile
						  title:(NSString *)title
						  digest:(NSString *)digest
							ima:(NSMutableArray *)ima{
	self = [super init];
	if (self) {


		_title = title;
		_imgsrc =profile;

		_digest = digest;

		_imgextraArray = ima;
	}
	return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
	
	Model *model = [Model modelWithProfile:nil title:nil digest:nil ima:nil];
	if (model) {
		[model setValuesForKeysWithDictionary:dic];
	}
	return model;
}


@end
