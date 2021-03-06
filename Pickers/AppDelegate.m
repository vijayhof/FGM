//
//  AppDelegate.m
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "PersistentApplicationData.h"
#import "Utility.h"
#import "SingleAppDataObject.h"
#import "MathScore.h"

#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize rootController;
@synthesize persistentApplicationData;
@synthesize theAppDataObject;

- (id) init;
{
    //	self.theAppDataObject = [[SingleAppDataObject alloc] init];
    self.persistentApplicationData = [Utility readFromArchive];
    if(self.persistentApplicationData == nil)
    {
        D2Log(@"persistent data is null");
        self.persistentApplicationData = [[PersistentApplicationData alloc] init];
    }
    else
    {
        D2Log(@"persistent data: currentNumber=%d, maxNumberArraySize=%d, currentOperation=%@, shuffleNumbers=%@, shuffleOperations=%@, mathScores=%d", persistentApplicationData.currentNumber, persistentApplicationData.maxNumberArraySize, persistentApplicationData.currentOperation, persistentApplicationData.shuffleNumbers ?@"YES" : @"NO", persistentApplicationData.shuffleOperations ? @"YES" : @"NO", [persistentApplicationData.mathScores count]);
        //[MathScore printArray:persistentApplicationData.mathScores];
    }
    
	return [super init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[NSBundle mainBundle] loadNibNamed:@"TabBarController" owner:self options:nil];
    //    [self.window addSubview:rootController.view];
    [self.window setRootViewController:rootController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [Crashlytics startWithAPIKey:@"f6a01dc31fc3712779512835183c573444bd340a"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
//    D2Log(@"will resign active");
    
    [Utility storeIntoArchive:persistentApplicationData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
