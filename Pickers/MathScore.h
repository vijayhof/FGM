//
//  AppDelegate.h
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MathScoreAnswerType) {
    kQnANotAttempted,
    kQnACorrectAnswer,
    kQnAWrongAnswer
};

//
// MathScore class
//
@interface MathScore : NSObject <NSCoding, NSCopying>

// persistent model properties 
@property (strong, nonatomic) NSDate   *startTime;
@property (strong, nonatomic) NSDate   *endTime;
@property (strong, nonatomic) NSString *operationType;
@property (assign, nonatomic) BOOL      shuffleNumbers;
@property (strong, nonatomic) NSMutableArray* eachScoreArr;

// computed properties
@property (assign, readonly, nonatomic) int totalQuestions;
@property (assign, readonly, nonatomic) int totalCorrect;
@property (assign, readonly, nonatomic) int totalWrong;
@property (assign, readonly, nonatomic) int totalNotAttempted;

// methods
- (id) initWithMathTableObjectArray:(NSMutableArray*)mathTableObjectArray;
- (void) setAnswerAtIndex:(NSUInteger) index withAnswerType:(MathScoreAnswerType) pAnswerType;
- (MathScoreAnswerType) answerAtIndex:(NSUInteger) index;
- (void) print;
+ (void) printArray:(NSMutableArray*) pBuffer;

@end

//
// MathEachScore class
//
@interface MathEachScore : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) MathScoreAnswerType answerType;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (nonatomic) int firstNumber;
@property (nonatomic) int secondNumber;
@property (nonatomic) int resultNumber;
@property (strong,nonatomic) NSString* operand;


@end