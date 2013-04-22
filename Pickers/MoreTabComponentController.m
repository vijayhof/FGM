//
//  BIDPresidentDetailController.m
//  Nav
//
//  Created by Jack Nutting on 9/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"
#import "MoreTabComponentController.h"
#import "AboutPageController.h"
#import "Utility.h"

@implementation MoreTabComponentController

@synthesize listEntries;

#pragma mark -
- (void) loadView
{
    [super loadView];
    
    UITableView* tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tv.dataSource = self;
    tv.delegate = self;
    self.view = tv;
    self.tableView = tv;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"More";
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = NULL;
    // About Page
    AboutPageController* aboutPageController = [[AboutPageController alloc]
                                                initWithNibName:@"AboutPageController" bundle:nil];
    aboutPageController.message = @"Version 2.1";
    aboutPageController.title = @"About";
    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:aboutPageController forKey:@"About"];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;
    
    // Give Feedback
    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:[[NSNull alloc] init] forKey:@"Feedback"];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;
    
    self.listEntries = dictArray;
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MoreCellIdentifier = @"MoreCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             MoreCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MoreCellIdentifier];
    }
    
    // Configure the cell
    NSUInteger row = [indexPath row];
    NSMutableDictionary* dictEntry = [self.listEntries objectAtIndex:row];
    cell.textLabel.text = [[dictEntry allKeys] objectAtIndex:0];
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSMutableDictionary* dictEntry = [self.listEntries objectAtIndex:row];
    id tmpObj = [[dictEntry allValues] objectAtIndex:0];
    NSString* tmpStr = [[dictEntry allKeys] objectAtIndex:0];
    if([tmpObj isKindOfClass:[UIViewController class]])
    {
        [self.navigationController pushViewController:tmpObj
                                             animated:YES];
        
    }
    else if([tmpStr isEqualToString:@"Feedback"])
    {
        D2Log(@"give feedback");
        [Utility launchMailAppOnDevice:@"support@hcsninc.com" cc:@"" bcc:@"" subject:@"Giving Feedback on" body:@""];
        D2Log(@"give feedback end");
    }
}

@end
