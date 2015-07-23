//
//  NSMutableArray+DepthCopy.h
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (DepthCopy)

- (void)depthCopyWithMutableArray:(NSMutableArray *)array;
@end
