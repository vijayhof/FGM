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

@synthesize currentNumber;
@synthesize maxNumberArraySize;
@synthesize currentOperation;
@synthesize shuffleNumbers;
@synthesize shuffleOperations;
@synthesize mathScores;

- (id) init
{
    self = [super init];
    if (self) {
        self.currentNumber      = kDefaultCurrentNumber;
        self.maxNumberArraySize = kDefaultMaxNumberArraySize;
        self.currentOperation   = kDefaultCurrentOperation;
        self.shuffleNumbers     = false;
        self.shuffleOperations  = false;
        self.mathScores         = nil;
    }
    return self;
}

#pragma mark NSCoding 
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:currentNumber       forKey:kCurrentNumberKey]; 
    [encoder encodeInt:maxNumberArraySize  forKey:kMaxNumberArraySizeKey]; 
    [encoder encodeObject:currentOperation forKey:kCurrentOperationKey]; 
    [encoder encodeBool:shuffleNumbers     forKey:kShuffleNumbersKey];
    [encoder encodeBool:shuffleOperations  forKey:kShuffleOperationsKey];
    [encoder encodeObject:mathScores       forKey:kMathScoresKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{ 
    if (self = [super init])
    { 
        currentNumber      = [decoder decodeIntForKey:kCurrentNumberKey];
        maxNumberArraySize = [decoder decodeIntForKey:kMaxNumberArraySizeKey];
        currentOperation   = [decoder decodeObjectForKey:kCurrentOperationKey]; 
        shuffleNumbers     = [decoder decodeBoolForKey:kShuffleNumbersKey];
        shuffleOperations  = [decoder decodeBoolForKey:kShuffleOperationsKey];
        mathScores         = [decoder decodeObjectForKey:kMathScoresKey];
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
