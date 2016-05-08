//  AppDelegate.m

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "OwnerLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Key to interact with Parse API
    [Parse setApplicationId:@"ZoFHgn6IfSnsuYTSkvZOkecTejs8Wa00dpEWU6go"
                  clientKey:@"RcYERJZfY2fDRpmz48rs7i6DpLWshMtuMliLA5qP"];
        
    [[UITabBar appearance] setTintColor:[UIColor darkGrayColor]];
    
    [self getLoginStatus];
    
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

-(void) showLoginScreen:(BOOL)animated
{
    
    // Get login screen from storyboard and present it
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OwnerLoginViewController *viewController = (OwnerLoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
    [self.window makeKeyAndVisible];
    [self.window.rootViewController presentViewController:viewController
                                                 animated:animated
                                               completion:nil];
}

-(void)getLoginStatus
{
    // Present login screen if user has not yet logged in
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin"] == nil)
    {
        [self showLoginScreen:YES];
        
    }
    else if([[standardDefaults stringForKey:@"loggedin"] isEqual: @"out"])
    {
        [self showLoginScreen:YES];
    }
}

@end
