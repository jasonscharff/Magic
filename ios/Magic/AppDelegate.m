//
//  AppDelegate.m
//  Magic
//
//  Created by Jason Scharff on 4/20/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import "AppDelegate.h"

#import "MGCSearchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  MGCSearchViewController *searchVC = [[MGCSearchViewController alloc]init];
  UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:searchVC];
  navController.navigationBar.translucent = NO;
  self.window.rootViewController = navController;
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
