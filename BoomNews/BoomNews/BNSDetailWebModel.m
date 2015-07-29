//
//  BNSDetailWebModel.m
//  BoomNews
//
//  Created by 邵垚 on 15/7/23.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSDetailWebModel.h"

@implementation BNSDetailWebModel


- (void)dealloc
{
    
    [_title release];
    [_source release];
    [_ptime release];
    [_body release];
    [_img release];
    [_docid release];
    [super dealloc];
}


- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


//归档反归档方法(自动调用) (需要遵循NSCoding协议)
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.ptime = [aDecoder decodeObjectForKey:@"ptime"];
        self.body = [aDecoder decodeObjectForKey:@"body"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.docid = [aDecoder decodeObjectForKey:@"docid"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.ptime forKey:@"ptime"];
    [aCoder encodeObject:self.body forKey:@"body"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.docid forKey:@"docid"];
    
}
@end
