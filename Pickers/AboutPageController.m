//
//  BIDDisclosureDetailController.m
//  Nav
//
//  Created by Jack Nutting on 9/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"
#import "AboutPageController.h"

@implementation AboutPageController
@synthesize label;
@synthesize message;

- (void)viewDidLoad
{
    D2Log(@"viewDidLoad");
    
    [super viewDidLoad];
    
    self.message = [[NSString alloc] initWithFormat:@"Version %@", [self readVersionFromPlist] ];
    
//    [label setNumberOfLines:0];
//    [label sizeToFit];
}

- (void)viewWillAppear:(BOOL)animated
{
    D2Log(@"viewWillAppear");

    label.text = message;
    [super viewWillAppear:animated];
}

- (NSString*)readVersionFromPlist
{
    NSString* value = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return value;
}

@end
