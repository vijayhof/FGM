//
//  ScoreTableViewCell.h
//  Math Tables for Kids
//
//  Created by Vijayant Palaiya on 7/26/13.
//  Copyright (c) 2013 Dave Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewCell : UITableViewCell

@property (copy,nonatomic) NSString* scoreTopic;
@property (copy,nonatomic) NSString* timeTaken;
@property (copy,nonatomic) NSString* actualScore;
@property (copy,nonatomic) NSString* startTime;

@property (weak,nonatomic) IBOutlet UILabel* scoreTopicLabel;
@property (weak,nonatomic) IBOutlet UILabel* timeTakenLabel;
@property (weak,nonatomic) IBOutlet UILabel* actualScoreLabel;
@property (weak,nonatomic) IBOutlet UILabel* startTimeLabel;

@end
