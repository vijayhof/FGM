//
//  ScoreTableViewCell.m
//  Math Tables for Kids
//
//  Created by Vijayant Palaiya on 7/26/13.
//  Copyright (c) 2013 Dave Mark. All rights reserved.
//

#import "ScoreTableViewCell.h"

@implementation ScoreTableViewCell

@synthesize scoreTopic;
@synthesize timeTaken;
@synthesize actualScore;
@synthesize startTime;

@synthesize scoreTopicLabel;
@synthesize timeTakenLabel;
@synthesize actualScoreLabel;
@synthesize startTimeLabel;

- (void) setScoreTopic:(NSString *)tp
{
    if(![tp isEqualToString:scoreTopic])
    {
        scoreTopic = [tp copy];
        scoreTopicLabel.text = scoreTopic;
    }
}

- (void) setTimeTaken:(NSString *)tt
{
    if(![tt isEqualToString:timeTaken])
    {
        timeTaken = [tt copy];
        timeTakenLabel.text = timeTaken;
    }
}

- (void) setActualScore:(NSString *)as
{
    if(![as isEqualToString:actualScore])
    {
        actualScore = [as copy];
        actualScoreLabel.text = actualScore;
    }
}


- (void) setStartTime:(NSString *)st
{
    if(![st isEqualToString:timeTaken])
    {
        startTime = [st copy];
        startTimeLabel.text = startTime;
    }
}

@end
