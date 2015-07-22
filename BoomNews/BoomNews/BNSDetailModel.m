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
    
    [_title release];
    [_digest release];
    [_imgsrc release];
    [_editorArray release];
    [_imgextraArray release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    

}
@end
