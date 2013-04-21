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


+ (void) setCurrentNumber: (int) pCurrentNumber;
+ (void) setMaxNumberArraySize: (int) pMaxNumberArraySize;
+ (void) setCurrentOperation: (NSString *) pCurrentOperation;
+ (void) setShuffleNumbers: (BOOL) pShuffleNumbers;
+ (void) setShuffleOperations: (BOOL) pShuffleOperations;
+ (void)launchMailAppOnDevice:(NSString*)toRecipients cc:(NSString*) ccRecipients bcc:(NSString*) bccRecipients subject:(NSString*)subjectStr body:(NSString*) bodyStr;
@end
