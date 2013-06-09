//
//  Utility.m
//  FGM
//
//  Created by Vijayant Palaiya on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "PersistentApplicationData.h"
#import "SingleAppDataObject.h"

@implementation Utility

#pragma mark - Custom Application Data Archive

//
// Get the path for the archive data file.
// Path is in Document directory, and under kCustomAppArchiveFilename folder.
//
// Returns the string with the path name
//
+ (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kCustomAppArchiveFilename];
}

//
// Store into persistent archive - path for which is determined by dataFilePath method above.
//
+ (void)storeIntoArchive:(PersistentApplicationData *)persistentApplicationData
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:persistentApplicationData forKey:kCustomAppDataKey];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
}

//
// Read data from persistent archive - path for which is determined by dataFilePath method above.
//
+ (PersistentApplicationData *)readFromArchive
{
    NSData *data = [[NSMutableData alloc]
                    initWithContentsOfFile:[self dataFilePath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                     initForReadingWithData:data];
    PersistentApplicationData *persistentApplicationData = [unarchiver decodeObjectForKey:kCustomAppDataKey];
    [unarchiver finishDecoding];
    
    return persistentApplicationData;
}

# pragma misc
+ (AppDelegate*) sharedAppDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

+ (SingleAppDataObject*) theAppDataObject
{
	return (SingleAppDataObject*) ([Utility sharedAppDelegate].theAppDataObject);
}

+ (int) getCurrentNumber
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    return tmpObj.currentNumber;
}

+ (int) getMaxNumberArraySize
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    return tmpObj.maxNumberArraySize;
}

+ (NSString*) getCurrentOperation
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    return tmpObj.currentOperation;
}

+ (BOOL) getShuffleNumbers
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    return tmpObj.shuffleNumbers;
}

+ (BOOL) getShuffleOperations
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    return tmpObj.shuffleOperations;
}

+ (void) setCurrentNumber: (int) pCurrentNumber
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    tmpObj.currentNumber = pCurrentNumber;
}

+ (void) setMaxNumberArraySize: (int) pMaxNumberArraySize
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    tmpObj.maxNumberArraySize = pMaxNumberArraySize;
}

+ (void) setCurrentOperation: (NSString *) pCurrentOperation
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    tmpObj.currentOperation = pCurrentOperation; // TODO - confirm retain/copy logic
}

+ (void) setShuffleNumbers: (BOOL) pShuffleNumbers
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    tmpObj.shuffleNumbers = pShuffleNumbers;
}

+ (void) setShuffleOperations: (BOOL) pShuffleOperations
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    tmpObj.shuffleOperations = pShuffleOperations;
}

//
// Return the directory where we will store the data files
//
+ (NSString *)dataFileDirectory
{
	// get document directory
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}

//
// Launches the Mail application on the device.
//
+(void)launchMailAppOnDevice:(NSString*)toRecipients cc:(NSString*) ccRecipients bcc:(NSString*) bccRecipients subject:(NSString*)subjectStr body:(NSString*) bodyStr
{
    NSString *email = [[NSString alloc] initWithFormat:@"mailto:%@?cc=%@&bcc=%@&subject=%@&body=%@",toRecipients, ccRecipients,bccRecipients,subjectStr,bodyStr];
    
    
//    @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
//    NSString *body = @"&body=It is raining in sunny California!";
//    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
//    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];

    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

@end
