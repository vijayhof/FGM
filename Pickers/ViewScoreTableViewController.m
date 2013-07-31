//
//  BIDPresidentDetailController.m
//  Nav
//
//  Created by Jack Nutting on 9/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"
#import "ViewScoreTableViewController.h"
#import "Utility.h"
#import "MathScore.h"
#import "ScoreTableViewCell.h"

#define kViewScoreIdentifier @"ViewScoreIdentifier"

@interface ViewScoreTableViewController ()

@property (strong, nonatomic) NSMutableArray *mutableArray;

@end

@implementation ViewScoreTableViewController

@synthesize mutableArray = _mutableArray;

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"View Scores";

    // register the custom table cell from the xib file
    UINib *nib = [UINib nibWithNibName:@"ScoreTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kViewScoreIdentifier];

    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete All" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteAllScores:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    self.mutableArray = [Utility getMathScores];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void) deleteAllScores: (id) sender
{
    [self.mutableArray removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    D2Log(@"count=%d", [self.mutableArray count]);
    return [self.mutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                kViewScoreIdentifier];
    
    // Configure the cell
    NSUInteger row = [indexPath row];
    MathScore* mathScore = [self.mutableArray objectAtIndex:row];
    cell.startTime = [Utility formatDateForScore:[mathScore startTime]];
    cell.timeTaken = [Utility formatTimeInterval:[mathScore startTime] betweenDate:[mathScore endTime]];
    int totalQuestions = [mathScore totalQuestions];
    int totalCorrect = [mathScore totalCorrect];
    cell.actualScore = [[NSString alloc] initWithFormat:@"%d / %d", totalCorrect, totalQuestions];
    cell.scoreTopic = [[NSString alloc] initWithFormat:@"%@ %d %@", [Utility formatOperationType:mathScore.operationType],
                       [[mathScore.eachScoreArr objectAtIndex:0] firstNumber], [mathScore shuffleNumbers] == YES ? @"(Shuffle)" : @""];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    [self.mutableArray removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [MathScore printArray:self.mutableArray];
}

@end
