//
//  AppDelegate.m
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import "MathScore.h"
#import "Constants.h"
#import "Utility.h"
#import "MathTableDataObject.h"
#import "CHCircularBuffer.h"

#define    kMathScoreStartTimeKey         @"mathScoreStartTime"
#define    kMathScoreEndTimeKey           @"mathScoreEndTime"
#define    kMathScoreOperationTypeKey     @"mathScoreOperationType"
#define    kMathScoreShuffleNumbersKey    @"mathScoreShuffleNumbers"
#define    kMathScoreEachScoreArrKey      @"mathScoreEachScoreArr"

#define    kMathEachScoreAnswerTypeKey    @"mathEachScoreAnswerType"
#define    kMathEachScoreStartTimeKey     @"mathEachScoreStartTime"
#define    kMathEachScoreEndTimeKey       @"mathEachScoreEndTime"
#define    kMathEachScoreFirstNumberKey   @"mathEachScoreFirstNumber"
#define    kMathEachScoreSecondNumberKey  @"mathEachScoreSecondNumber"
#define    kMathEachScoreResultNumberKey  @"mathEachScoreResultNumber"
#define    kMathEachScoreOperandKey       @"mathEachScoreOperand"

@implementation MathScore

@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize operationType = _operationType;
@synthesize shuffleNumbers = _shuffleNumbers;
@synthesize eachScoreArr = _eachScoreArr;

@synthesize totalQuestions = _totalQuestions;
@synthesize totalCorrect = _totalCorrect;
@synthesize totalWrong = _totalWrong;
@synthesize totalNotAttempted = _totalNotAttempted;

- (id) init
{
    self = [super init];
    if (self) {
        self.startTime      = nil;
        self.endTime        = nil;
        self.operationType  = nil;
        self.shuffleNumbers = false;
        self.eachScoreArr   = nil;
    }
    return self;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.startTime        forKey:kMathScoreStartTimeKey];
    [encoder encodeObject:self.endTime          forKey:kMathScoreEndTimeKey];
    [encoder encodeObject:self.operationType    forKey:kMathScoreOperationTypeKey];
    [encoder encodeBool:self.shuffleNumbers     forKey:kMathScoreShuffleNumbersKey];
    [encoder encodeObject:self.eachScoreArr     forKey:kMathScoreEachScoreArrKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.startTime           = [decoder decodeObjectForKey:kMathScoreStartTimeKey];
        self.endTime             = [decoder decodeObjectForKey:kMathScoreEndTimeKey];
        self.operationType       = [decoder decodeObjectForKey:kMathScoreOperationTypeKey];
        self.shuffleNumbers      = [decoder decodeBoolForKey:kMathScoreShuffleNumbersKey];
        self.eachScoreArr        = [decoder decodeObjectForKey:kMathScoreEachScoreArrKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    MathScore *copy = [[[self class] allocWithZone:zone] init];
    copy.startTime       = [self.startTime copyWithZone:zone];
    copy.endTime         = [self.endTime copyWithZone:zone];
    copy.operationType   = [self.operationType copyWithZone:zone];
    copy.shuffleNumbers  = self.shuffleNumbers;
    copy.eachScoreArr    = [self.eachScoreArr copyWithZone:zone];
    return copy;
}

- (id) initWithMathTableObjectArray:(NSMutableArray*)mathTableDataObjectArray
{
    self = [self init];
    if(self)
    {
        self.startTime = [NSDate date];
        self.endTime = nil;
        self.operationType = [Utility getCurrentOperation]; // todo - figure out string assignment
        self.shuffleNumbers = [Utility getShuffleNumbers];
        
        int size = [mathTableDataObjectArray count];
        self.eachScoreArr = [[NSMutableArray alloc] initWithCapacity:size];
        MathTableDataObject* mathTableDataObject = nil;
        MathEachScore* mathEachScore = nil;
        for(int i = 0; i < size; i++)
        {
            mathTableDataObject = [mathTableDataObjectArray objectAtIndex:i];
            mathEachScore = [[MathEachScore alloc] init];
            mathEachScore.answerType = kQnANotAttempted;
            mathEachScore.startTime = self.startTime;
            mathEachScore.endTime = nil;
            mathEachScore.firstNumber = mathTableDataObject.firstNumber;
            mathEachScore.secondNumber = mathTableDataObject.secondNumber;
            mathEachScore.resultNumber = mathTableDataObject.resultNumber;
            mathEachScore.operand = mathTableDataObject.operand;
            
            [self.eachScoreArr addObject:mathEachScore];
        }
    }
    
    return self;
}

- (void) setAnswerAtIndex:(NSUInteger) index withAnswerType:(MathScoreAnswerType) pAnswerType
{
    MathEachScore* eachScore = [self.eachScoreArr objectAtIndex:index];
    self.endTime = [NSDate date];
    eachScore.endTime = [NSDate date];
    eachScore.answerType = pAnswerType;
}

- (MathScoreAnswerType) answerAtIndex:(NSUInteger) index
{
    MathEachScore* eachScore = [self.eachScoreArr objectAtIndex:index];
    return [eachScore answerType];
}

- (int)totalQuestions
{
    if(self.eachScoreArr != nil)
    {
        return [self.eachScoreArr count];
    }
    
    return 0;
}

- (int)totalCorrect
{
    return [self computeTotalCount: kQnACorrectAnswer];
}

- (int)totalWrong
{
    return [self computeTotalCount: kQnAWrongAnswer];
}

- (int)totalNotAttempted
{
    return [self computeTotalCount: kQnANotAttempted];
}

- (int)computeTotalCount:(MathScoreAnswerType) answerType
{
    int counter = 0;
    
    if(self.eachScoreArr != nil)
    {
        for(MathEachScore* eachScore in self.eachScoreArr)
        {
            if(eachScore != nil)
            {
                if([eachScore answerType] == answerType)
                {
                    counter++;
                }
            }
        }
    }
    
    return counter;
}


- (void) print
{
    D2Log(@"print MathScore");
    D2Log(@"mathScore: %@, %@, %d", self.startTime, self.endTime, [self.eachScoreArr count]);
    for(MathEachScore* eachScore in self.eachScoreArr)
    {
        D2Log(@"mathEachScore:%d, %@, %@, %d, %d, %d, %@",
        eachScore.answerType, eachScore.startTime, eachScore.endTime, eachScore.firstNumber, eachScore.secondNumber, eachScore.resultNumber, eachScore.operand);
    }
}

+ (void) printArray:(CHCircularBuffer*) pBuffer
{
    D2Log(@"print MathScore Array: count=%d", [pBuffer count]);
    for(MathScore* mathScore in pBuffer)
    {
        [mathScore print];
    }
}

@end

#pragma mark - MathEachScore
@implementation MathEachScore

@synthesize answerType = _answerType;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize firstNumber = _firstNumber;
@synthesize secondNumber = _secondNumber;
@synthesize operand = _operand;
@synthesize resultNumber = _resultNumber;

- (id) init
{
    self = [super init];
    if (self) {
        self.answerType    = kQnANotAttempted;
        self.startTime     = nil;
        self.endTime       = nil;
        self.firstNumber   = 0;
        self.secondNumber  = 0;
        self.resultNumber  = 0;
        self.operand       = nil;
    }
    return self;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.answerType forKey:kMathEachScoreAnswerTypeKey];
    [encoder encodeObject:self.startTime   forKey:kMathEachScoreStartTimeKey];
    [encoder encodeObject:self.endTime     forKey:kMathEachScoreEndTimeKey];
    [encoder encodeInt:self.firstNumber    forKey:kMathEachScoreFirstNumberKey];
    [encoder encodeInt:self.secondNumber   forKey:kMathEachScoreSecondNumberKey];
    [encoder encodeInt:self.resultNumber   forKey:kMathEachScoreResultNumberKey];
    [encoder encodeObject:self.operand     forKey:kMathEachScoreOperandKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.answerType     = [decoder decodeIntegerForKey:kMathEachScoreAnswerTypeKey];
        self.startTime      = [decoder decodeObjectForKey:kMathEachScoreStartTimeKey];
        self.endTime        = [decoder decodeObjectForKey:kMathEachScoreEndTimeKey];
        self.firstNumber    = [decoder decodeIntForKey:kMathEachScoreFirstNumberKey];
        self.secondNumber   = [decoder decodeIntForKey:kMathEachScoreSecondNumberKey];
        self.resultNumber   = [decoder decodeIntForKey:kMathEachScoreResultNumberKey];
        self.operand        = [decoder decodeObjectForKey:kMathEachScoreOperandKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    MathEachScore *copy = [[[self class] allocWithZone:zone] init];
    copy.answerType    = self.answerType;
    copy.startTime     = [self.startTime copyWithZone:zone];
    copy.endTime       = [self.endTime copyWithZone:zone];
    copy.firstNumber   = self.firstNumber;
    copy.secondNumber  = self.secondNumber;
    copy.resultNumber  = self.resultNumber;
    copy.operand       = [self.operand copyWithZone:zone];
    return copy;
}

@end
