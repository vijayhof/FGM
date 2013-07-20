//
//  AppDelegate.h
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kQnANotAttempted,
    kQnACorrectAnswer,
    kQnAWrongAnswer
} MathScoreAnswerType;

@interface MathScore : NSObject <NSCoding, NSCopying>

@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) NSMutableArray* eachScoreArr;

- (id) initWithMathTableObjectArray:(NSMutableArray*)mathTableObjectArray;
- (void) setAnswerAtIndex:(NSUInteger) index withAnswerType:(MathScoreAnswerType) pAnswerType;
- (MathScoreAnswerType) answerAtIndex:(NSUInteger) index;

@end

@interface MathEachScore : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) MathScoreAnswerType answerType;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (nonatomic) int firstNumber;
@property (nonatomic) int secondNumber;
@property (nonatomic) int resultNumber;
@property (strong,nonatomic) NSString* operand;


@end