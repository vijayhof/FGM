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

@implementation MoreTabComponentController

@synthesize controllers;

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
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // About Page
    AboutPageController* aboutPageController = [[AboutPageController alloc]
                       initWithNibName:@"AboutPageController" bundle:nil];
    aboutPageController.message = @"Version 2.1";
    aboutPageController.title = @"About";
    [array addObject:aboutPageController];
    
    self.controllers = array;

}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
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
    UIViewController *controller = [controllers objectAtIndex:row];
    cell.textLabel.text = controller.title;
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    D2Log(@"didSelectRowAtIndexPath");
    NSUInteger row = [indexPath row];
    UIViewController *nextController = [self.controllers
                                                    objectAtIndex:row];
    D2Log(@"didSelectRowAtIndexPath tile %@", nextController.title);
    [self.navigationController pushViewController:nextController
                                         animated:YES];

    D2Log(@"didSelectRowAtIndexPath done");

}

@end
