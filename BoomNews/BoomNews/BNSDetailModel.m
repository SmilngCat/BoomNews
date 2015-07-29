//
//  BNSDetailModel.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSDetailModel.h"

@implementation BNSDetailModel

- (void)dealloc {
    
    [_skipID release];
    [_docid release];
    [_imgsum release];
    [_imgurl release];
    [_imgtitle release];
    [_setname release];
    [_note release];
    [_skipType release];
    [_specialID release];
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
	
}




@end
