//
//  AppDelegate.m
//  HomeWorkViewControllerDelegate
//
//  Created by Михаил Асмаковец on 17.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ViewController.h"
#import "MyViewControllerDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) MyViewControllerDelegate *naviDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RootViewController *rootViewController = [RootViewController new];
    UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.naviDelegate = [MyViewControllerDelegate new];
    [navViewController setDelegate: self.naviDelegate];
    
    
    ViewController *viewController = [ViewController new];
    
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks
                                                                     tag:1];
    navViewController.tabBarItem = item1;
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch
                                                                     tag:2];
    viewController.tabBarItem = item2;
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    tabBar.viewControllers = @[navViewController, viewController];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
