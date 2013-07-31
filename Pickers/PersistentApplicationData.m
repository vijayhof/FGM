//
//  PersistentApplicationData.m
//  FGM
//
//  Created by Vijayant Palaiya on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PersistentApplicationData.h"
#import "Constants.h"

#define    kCurrentNumberKey        @"currentNumber"
#define    kMaxNumberArraySizeKey   @"maxNumberArraySize"
#define    kCurrentOperationKey     @"currentOperation"
#define    kShuffleNumbersKey       @"shuffleNumbers"
#define    kShuffleOperationsKey    @"shuffleOperations"
#define    kMathScoresKey           @"mathScores"

@implementation PersistentApplicationData

@synthesize currentNumber = _currentNumber;
@synthesize maxNumberArraySize = _maxNumberArraySize;
@synthesize currentOperation = _currentOperation;
@synthesize shuffleNumbers = _shuffleNumbers;
@synthesize shuffleOperations = _shuffleOperations;
@synthesize mathScores = _mathScores;

- (id) init
{
    self = [super init];
    if (self) {
        self.currentNumber      = kDefaultCurrentNumber;
        self.maxNumberArraySize = kDefaultMaxNumberArraySize;
        self.currentOperation   = kDefaultCurrentOperation;
        self.shuffleNumbers     = false;
        self.shuffleOperations  = false;
        self.mathScores         = [[NSMutableArray alloc] initWithCapacity:kDefaultScoreArraySize];
    }
    return self;
}

#pragma mark NSCoding 
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self.currentNumber       forKey:kCurrentNumberKey];
    [encoder encodeInt:self.maxNumberArraySize  forKey:kMaxNumberArraySizeKey];
    [encoder encodeObject:self.currentOperation forKey:kCurrentOperationKey];
    [encoder encodeBool:self.shuffleNumbers     forKey:kShuffleNumbersKey];
    [encoder encodeBool:self.shuffleOperations  forKey:kShuffleOperationsKey];
    [encoder encodeObject:self.mathScores       forKey:kMathScoresKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{ 
    if (self = [super init])
    { 
        self.currentNumber      = [decoder decodeIntForKey:kCurrentNumberKey];
        self.maxNumberArraySize = [decoder decodeIntForKey:kMaxNumberArraySizeKey];
        self.currentOperation   = [decoder decodeObjectForKey:kCurrentOperationKey];
        self.shuffleNumbers     = [decoder decodeBoolForKey:kShuffleNumbersKey];
        self.shuffleOperations  = [decoder decodeBoolForKey:kShuffleOperationsKey];
        self.mathScores         = [decoder decodeObjectForKey:kMathScoresKey];
    }
    
    return self; 
} 

#pragma mark - 
#pragma mark NSCopying 
- (id)copyWithZone:(NSZone *)zone
{ 
    PersistentApplicationData *copy = [[[self class] allocWithZone:zone] init]; 
    copy.currentNumber      = self.currentNumber;
    copy.maxNumberArraySize = self.maxNumberArraySize;
    copy.currentOperation   = [self.currentOperation copyWithZone:zone];
    copy.shuffleNumbers     = self.shuffleNumbers; 
    copy.shuffleOperations  = self.shuffleOperations; 
    copy.mathScores         = [self.mathScores copyWithZone:zone];
    return copy;
}

@end
