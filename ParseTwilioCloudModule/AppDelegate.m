//
//  AppDelegate.m
//  ParseTwilioCloudModule
//
//  Created by Mattieu Gamache-Asselin on 10/25/12.
//

#import "AppDelegate.h"
#import "FriendsTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Add your Parse credentials here
    
    [Parse setApplicationId:@"PARSE_APPLICATION_ID"
                  clientKey:@"PARSE_CLIENT_KEY"];
    //
    // ****************************************************************************
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    FriendsTableViewController *viewController = [[FriendsTableViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    return YES;
}

@end
