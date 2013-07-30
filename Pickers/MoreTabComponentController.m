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
#import "ViewScoreTableViewController.h"
#import "Utility.h"

#define kMoreTopSection                @"My Stuff"
#define kMoreBottomSection             @"App Info"

#define kViewScoreString               @"View Scores"
#define kRateAppString                 @"Rate this App"
#define kShareAppString                @"Share this App"
#define kGiveFeedbackString            @"Give Feedback"

@interface MoreTabComponentController ()

@property (strong, nonatomic) NSMutableArray *sectionArray;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;

@end

@implementation MoreTabComponentController

@synthesize sectionArray = _sectioNArray;
@synthesize dataDictionary = _dataDictionary;

#pragma mark -
- (void) loadView
{
    [super loadView];
    
    UITableView* tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tv.dataSource = self;
    tv.delegate = self;
    [tv setBackgroundView:nil];
    tv.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    self.view = tv;
    self.tableView = tv;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"More";
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    NSMutableDictionary* tmpDict = NULL;
    _dataDictionary = [[NSMutableDictionary alloc] init];

    //
    // top section - View Scores
    //
    
    // View Scores
    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:[[NSNull alloc] init] forKey:kViewScoreString];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;
    
    [_dataDictionary setObject:dictArray forKey:kMoreTopSection];
    

    //
    // next section - Rate, Share, Feedback, About
    //
    dictArray = [[NSMutableArray alloc] init];
    
    // Give Rating
    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:[[NSNull alloc] init] forKey:kRateAppString];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;
    
    // Share
    NSArray* arrayActivityItems = [NSArray arrayWithObjects:@"Get this app 'Math Tables for Kids' on AppStore - http://itunes.apple.com/us/app/math-tables-for-kids/id641692138?mt=8",nil];
    UIActivityViewController* activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:arrayActivityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToWeibo];
    activityVC.title = kShareAppString;
    [activityVC setValue:@"Sharing a Math app" forKey:@"subject"];

    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:activityVC forKey:kShareAppString];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;

    // Give Feedback
    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:[[NSNull alloc] init] forKey:kGiveFeedbackString];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;

    // About Page
    AboutPageController* aboutPageController = [[AboutPageController alloc]
                                                initWithNibName:@"AboutPageController" bundle:nil];
    aboutPageController.title = @"About";
    tmpDict = [[NSMutableDictionary alloc] init];
    [tmpDict setObject:aboutPageController forKey:@"About"];
    [dictArray addObject:tmpDict];
    tmpDict = NULL;
    
    // next section
    [_dataDictionary setObject:dictArray forKey:kMoreBottomSection];
    

    self.sectionArray = [[NSMutableArray alloc] initWithObjects:kMoreTopSection, kMoreBottomSection, nil];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionArray count];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = [self.sectionArray objectAtIndex:section];
    NSMutableArray* rowArray = [self.dataDictionary objectForKey:key];
    return [rowArray count];
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

    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString* key = [self.sectionArray objectAtIndex:section];
    NSMutableArray* rowArray = [self.dataDictionary objectForKey:key];
    
    NSString* tmpStr = [[[rowArray objectAtIndex:row] allKeys] objectAtIndex:0];
    cell.textLabel.text = tmpStr;

    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString* key = [self.sectionArray objectAtIndex:section];
    NSMutableArray* rowArray = [self.dataDictionary objectForKey:key];

    NSString* tmpStr = [[[rowArray objectAtIndex:row] allKeys] objectAtIndex:0];
    
    id tmpObj = [[rowArray objectAtIndex:row] objectForKey:tmpStr];
    
    if([tmpStr isEqualToString:kShareAppString])
    {
        // Share this app
        [self presentViewController:tmpObj animated:YES completion:nil];
    }
    else if([tmpObj isKindOfClass:[UIViewController class]])
    {
        // About page
        [self.navigationController pushViewController:tmpObj
                                             animated:YES];
        
    }
    else if([tmpStr isEqualToString:kGiveFeedbackString])
    {
        // Give Feedback
        [Utility launchMailAppOnDevice:@"support@hcsninc.com" cc:@"" bcc:@"" subject:@"Giving Feedback on" body:@""];
    }
    else if([tmpStr isEqualToString:kViewScoreString])
    {
        // View Score
        id controller = [[ViewScoreTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([tmpStr isEqualToString:kRateAppString])
    {
        // Rate this app
        NSString *templateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";
        
        NSString *reviewURL = [templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", @"641692138"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
    }
}

@end
