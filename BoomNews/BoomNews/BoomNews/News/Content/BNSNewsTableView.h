//
//  BNSNewsEntertainmentTableView.h
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView.h"
#import "BNSTableView+BNSTemplateCell.h"
#import "BNSTableView+BNSHeightCache.h"

@interface BNSNewsTableView : BNSTableView

- (void)bns_LoadData:(NSUInteger)index;
@end
