//
//  BNSModeCell.m
//  BoomNews
//
//  Created by jsix lei on 15/7/15.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSModelCell.h"

@implementation BNSModelCell

@synthesize model = _model;


#pragma mark - BNSModelCell Lifecycle

- (void)dealloc {
	
	[_model release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
			  reuseIdentifier:(NSString *)identifier {
	self = [super initWithStyle:style reuseIdentifier:identifier];
	if (self) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontChanged:) name:kBNSTintFontChanged object:nil];
	}
	return self;
}

#pragma mark - Notification

- (void)fontChanged:(NSNotification *)notification {

}


@end
