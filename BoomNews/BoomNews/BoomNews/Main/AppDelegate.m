//
//  AppDelegate.m
//  BoomNews
//
//  Created by jsix lei on 15/7/15.
//  Copyright (c) 2015年 jsix lei. All rights reserved.
//

#import "AppDelegate.h"
#import "BNSRootViewController.h"
#import "BNSNewsViewController.h"
#import "BNSVideoViewController.h"
#import "BNSAccountViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc {
	[_window release];
	[super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	// Override point for customization after application launch.
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	
	//configure view controller hierarchy
	
	//rootViewController - tabBarController
	BNSRootViewController *rootViewController = [[[BNSRootViewController alloc] init] autorelease];
	
	//newsViewController - embed in a navigationController
	BNSNewsViewController *newsViewController = [[[BNSNewsViewController alloc] init] autorelease];
	UINavigationController *newsNavigationController = [[[UINavigationController alloc] initWithRootViewController:newsViewController] autorelease];
	newsViewController.navigationItem.title = @"新闻";
	newsNavigationController.tabBarItem.title = @"新闻";
	
	//videoViewController - embed in a navigationController
	BNSVideoViewController *videoViewController = [[[BNSVideoViewController alloc] init] autorelease];
	UINavigationController *videoNavigationController = [[[UINavigationController alloc] initWithRootViewController:videoViewController] autorelease];
	videoViewController.navigationItem.title = @"视听";
	videoNavigationController.tabBarItem.title = @"视听";
	
	//accountViewController - embed in a navigationController
	BNSAccountViewController *accountViewController = [[[BNSAccountViewController alloc] init] autorelease];
	accountViewController.tabBarItem.title = @"我的";
	
	rootViewController.viewControllers = @[newsNavigationController,
										   videoNavigationController,
										   accountViewController];
	
	self.window.rootViewController = rootViewController;
	
	//保存TabBar的高度
	CGFloat tabBarHeight = CGRectGetHeight(rootViewController.tabBar.frame);
	[[NSUserDefaults standardUserDefaults] setFloat:tabBarHeight forKey:@"tabBarHeight"];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
