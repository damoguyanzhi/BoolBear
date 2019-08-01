//
//  AppDelegate.m
//  BoolBear
//
//  Created by RuqiangLiu on 2018/5/4.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "UIButtonShowViewController.h"
#import "UILabelShowViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    MainTableViewController *mainVC = [[MainTableViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    nav.navigationBarHidden = YES;
    UITabBarController *tabVC = [[UITabBarController alloc]init];
   
    UIButtonShowViewController *vcB = [[UIButtonShowViewController alloc]init];
    UILabelShowViewController *vcC = [[UILabelShowViewController alloc]init];
    
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@""] tag:0];
    vcB.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"知识点" image:[UIImage imageNamed:@""] tag:1];
    vcC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"其他" image:[UIImage imageNamed:@""] tag:2];
    
    tabVC.viewControllers= @[nav,vcB,vcC];
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
