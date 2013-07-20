//
//  PersistentApplicationData.h
//  FGM
//
//  Created by Vijayant Palaiya on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MathScore;

@interface PersistentApplicationData : NSObject <NSCoding, NSCopying>

@property (nonatomic) int currentNumber;
@property (nonatomic) int maxNumberArraySize;
@property (strong,nonatomic) NSString* currentOperation;
@property (nonatomic) BOOL shuffleNumbers;
@property (nonatomic) BOOL shuffleOperations;
@property (strong,nonatomic) NSMutableArray* mathScores;

@end
