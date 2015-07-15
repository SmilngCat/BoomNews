//
//  Model.h
//  项目界面
//
//  Created by 邵垚 on 15/7/13.
//  Copyright (c) 2015年 邵垚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, copy)NSString *alias;

@property (nonatomic, copy)NSString *boardid;

@property (nonatomic, copy)NSString *cid;

@property (nonatomic, copy)NSString *digest;

@property (nonatomic, copy)NSString *docid;

@property (nonatomic, copy)NSString *ename;

@property (nonatomic, copy)NSString *hasAD;

@property (nonatomic, copy)NSString *hasCover;

@property (nonatomic, copy)NSString *imgsrc;

@property (nonatomic, copy)NSString *lmodify;

@property (nonatomic, copy)NSString *url_3w;

@property (nonatomic, copy)NSString *url;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, copy)NSString *source;

@property (nonatomic, retain)NSMutableArray *imgextraArray;


@end
