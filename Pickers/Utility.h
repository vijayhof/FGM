//
//  Utility.h
//  FGM
//
//  Created by Vijayant Palaiya on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersistentApplicationData;
@class SingleAppDataObject;
@class AppDelegate;

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]



@interface Utility : NSObject

+ (void)storeIntoArchive:(PersistentApplicationData *) persistentApplicationData;
+ (PersistentApplicationData *)readFromArchive;
+ (AppDelegate*) sharedAppDelegate;
+ (SingleAppDataObject*) theAppDataObject;
+ (NSString *)dataFileDirectory;

+ (int) getCurrentNumber;
+ (int) getMaxNumberArraySize;
+ (NSString*) getCurrentOperation;
+ (BOOL) getShuffleNumbers;
+ (BOOL) getShuffleOperations;
+ (NSMutableArray*) getMathScores;

+ (void) setCurrentNumber: (int) pCurrentNumber;
+ (void) setMaxNumberArraySize: (int) pMaxNumberArraySize;
+ (void) setCurrentOperation: (NSString *) pCurrentOperation;
+ (void) setShuffleNumbers: (BOOL) pShuffleNumbers;
+ (void) setShuffleOperations: (BOOL) pShuffleOperations;
+ (void) setMathScores: (NSMutableArray *) pMathScores;

// returns "Add" instead of ADD, etc
+ (NSString*) formatOperationType:(NSString*)operationType;

+ (void)launchMailAppOnDevice:(NSString*)toRecipients cc:(NSString*) ccRecipients bcc:(NSString*) bccRecipients subject:(NSString*)subjectStr body:(NSString*) bodyStr;
+ (NSString*)formatDateForScore:(NSDate*) date;
+ (NSString*)formatTimeInterval:(NSDate*) date1 betweenDate:(NSDate*) date2;

@end
