//
//  AppDelegate.m
//  Homepwner
//
//  Created by Zaur Giyasov on 20/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemsViewController.h"
#import "ItemStore.h"
#import "ImageStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ItemsViewController *ivc = [[ItemsViewController alloc] init];
    
    // Create NC
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ivc];
    self.window.rootViewController = nc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%@ - now in background", application.description);
    [[ImageStore sharedStore] clearOurCache];
    BOOL success = [[ItemStore sharedStore] saveChanges];
    
    if (success) {
        NSLog(@"Save my Items!");
    } else {
        NSLog(@"Not save any Items!");
    }
}

@end
