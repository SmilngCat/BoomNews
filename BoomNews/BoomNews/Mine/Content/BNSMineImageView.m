//
//  BNSMineImageView.m
//  BoomNews
//
//  Created by jsix lei on 15/7/22.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "BNSMineImageView.h"


#define FONT_LABEL 15

@interface BNSMineImageView ()

@property (retain, nonatomic) UIButton *avatarButton;
@property (retain, nonatomic) UILabel *loginLabel;
@end

@implementation BNSMineImageView

#pragma mark - BNSMineImageView Lifecycle

- (void)dealloc {
	
	[_loginLabel release];
	[_avatarButton release];
	[super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithRed:1.000 green:0.430 blue:0.175 alpha:1.000];
		[self buildLayout];
	}
	return self;
}


#pragma mark - Layout

- (void)buildLayout {
	[self addSubview:self.avatarButton];
	[self addSubview:self.loginLabel];
	
	//button
	[self addConstraint:[NSLayoutConstraint constraintWithItem:_avatarButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:_avatarButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
	
	//label
	[self addConstraint:[NSLayoutConstraint constraintWithItem:_loginLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:_loginLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_avatarButton attribute:NSLayoutAttributeBottom multiplier:1.f constant:20]];
	
}


#pragma mark - Actions

- (void)clicked:(UIButton *)sender {
	NSLog(@"登陆失败");
}

#pragma mark - Lazy loading

- (UIButton *)avatarButton {
	if (!_avatarButton) {
		_avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_avatarButton setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
		[_avatarButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
		_avatarButton.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _avatarButton;
}

- (UILabel *)loginLabel {
	if (!_loginLabel) {
		_loginLabel = [[UILabel alloc] init];
		_loginLabel.text = @"立即登陆";
		
		_loginLabel.textColor = [UIColor whiteColor];
		_loginLabel.translatesAutoresizingMaskIntoConstraints = NO;
	}
	return _loginLabel;
}

@end
