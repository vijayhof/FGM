//
//  AppDelegate.h
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleAppDataObject;
@class PersistentApplicationData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *rootController;

@property (strong, nonatomic) SingleAppDataObject* theAppDataObject;
@property (strong, nonatomic) PersistentApplicationData *persistentApplicationData;

@end
