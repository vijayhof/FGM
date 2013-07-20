//
//  AppDelegate.m
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import "MathScore.h"
#import "Constants.h"
#import "MathTableDataObject.h"

#define    kMathScoreStartTimeKey        @"mathScoreStartTime"
#define    kMathScoreEndTimeKey          @"mathScoreEndTime"
#define    kMathScoreEachScoreArrKey     @"mathScoreEachScoreArr"

#define    kMathEachScoreStartTimeKey    @"mathEachScoreStartTime"
#define    kMathEachScoreEndTimeKey      @"mathEachScoreEndTime"
#define    kMathEachScoreFirstNumberKey  @"mathEachScoreFirstNumber"
#define    kMathEachScoreSecondNumberKey @"mathEachScoreSecondNumber"
#define    kMathEachScoreResultNumberKey @"mathEachScoreResultNumber"
#define    kMathEachScoreOperandKey      @"mathEachScoreOperand"

@implementation MathScore

@synthesize startTime;
@synthesize endTime;
@synthesize eachScoreArr;

- (id) init
{
    self = [super init];
    if (self) {
        self.startTime     = nil;
        self.endTime       = nil;
        self.eachScoreArr  = nil;
    }
    return self;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:startTime    forKey:kMathScoreStartTimeKey];
    [encoder encodeObject:endTime      forKey:kMathScoreEndTimeKey];
    [encoder encodeObject:eachScoreArr forKey:kMathScoreEachScoreArrKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        startTime     = [decoder decodeObjectForKey:kMathScoreStartTimeKey];
        endTime       = [decoder decodeObjectForKey:kMathScoreEndTimeKey];
        eachScoreArr  = [decoder decodeObjectForKey:kMathScoreEachScoreArrKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    MathScore *copy = [[[self class] allocWithZone:zone] init];
    copy.startTime     = [self.startTime copyWithZone:zone];
    copy.endTime       = [self.endTime copyWithZone:zone];
    copy.eachScoreArr  = [self.eachScoreArr copyWithZone:zone];
    return copy;
}

- (id) initWithMathTableObjectArray:(NSMutableArray*)mathTableDataObjectArray
{
    self = [self init];
    if(self)
    {
        self.startTime = [NSDate date];
        self.endTime = nil;
        
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

@end

#pragma mark - MathEachScore
@implementation MathEachScore

@synthesize answerType;
@synthesize startTime;
@synthesize endTime;
@synthesize firstNumber;
@synthesize secondNumber;
@synthesize operand;
@synthesize resultNumber;

- (id) init
{
    self = [super init];
    if (self) {
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
    [encoder encodeObject:startTime  forKey:kMathEachScoreStartTimeKey];
    [encoder encodeObject:endTime    forKey:kMathEachScoreEndTimeKey];
    [encoder encodeInt:firstNumber   forKey:kMathEachScoreFirstNumberKey];
    [encoder encodeInt:secondNumber  forKey:kMathEachScoreSecondNumberKey];
    [encoder encodeInt:resultNumber  forKey:kMathEachScoreResultNumberKey];
    [encoder encodeObject:operand    forKey:kMathEachScoreOperandKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        startTime     = [decoder decodeObjectForKey:kMathEachScoreStartTimeKey];
        endTime       = [decoder decodeObjectForKey:kMathEachScoreEndTimeKey];
        firstNumber   = [decoder decodeIntForKey:kMathEachScoreFirstNumberKey];
        secondNumber  = [decoder decodeIntForKey:kMathEachScoreSecondNumberKey];
        resultNumber  = [decoder decodeIntForKey:kMathEachScoreResultNumberKey];
        operand       = [decoder decodeObjectForKey:kMathEachScoreOperandKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    MathEachScore *copy = [[[self class] allocWithZone:zone] init];
    copy.startTime     = [self.startTime copyWithZone:zone];
    copy.endTime       = [self.endTime copyWithZone:zone];
    copy.firstNumber   = self.firstNumber;
    copy.secondNumber  = self.secondNumber;
    copy.resultNumber  = self.resultNumber;
    copy.operand       = [self.operand copyWithZone:zone];
    return copy;
}

@end
