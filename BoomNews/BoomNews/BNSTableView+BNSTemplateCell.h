//
//  BNSTableView+BNSTemplateCell.h
//  BoomNews
//
//  Created by jsix lei on 15/7/16.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSTableView.h"
#import "BNSModelCell.h"


@interface BNSTableView (BNSTemplateCell)

- (BNSModelCell *)bns_templateCellWithIdentifier:(NSString *)identifier;
@end
