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
#import "CHCircularBuffer.h"
#import "MathScore.h"

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

//
// Get persistent data methods
//
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

+ (CHCircularBuffer*) getMathScores
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    if (!tmpObj.mathScores) {
        tmpObj.mathScores = [[CHCircularBuffer alloc] initWithCapacity:kDefaultScoreArraySize];
    }
    
    D2Log(@"Utility.getMathScores");
    [MathScore printArray:tmpObj.mathScores];
    
    return tmpObj.mathScores;
}


//
// Set persistent data methods
//
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

+ (void) setMathScores:(CHCircularBuffer *)pMathScores
{
    PersistentApplicationData* tmpObj = [Utility sharedAppDelegate].persistentApplicationData;
    tmpObj.mathScores = pMathScores; // TODO - confirm retain/copy logic
    D2Log(@"Utility.setMathScores");
    [MathScore printArray:tmpObj.mathScores];
}

+ (NSString*) formatOperationType:(NSString*)operationType
{
    if([operationType isEqualToString:kADD_OP]) return @"Add";
    else if([operationType isEqualToString:kSUB_OP]) return @"Sub";
    else if([operationType isEqualToString:kMUL_OP]) return @"Multiply";
    else if([operationType isEqualToString:kDIV_OP]) return @"Divide";
    
    return @"";
}

//
// default date format for score
//
+ (NSString*)formatDateForScore:(NSDate*) date
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:kDefaultDateFormatForScore];
	return [formatter stringFromDate:date];
}

//
// return time difference in format - 99 m 99 s
// date2 > date1 - it is expected that date2 is greater than date1
//
+ (NSString*)formatTimeInterval:(NSDate*) date1 betweenDate:(NSDate*) date2
{
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date1];
    NSInteger ti = (NSInteger)timeInterval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if(hours > 0)
    {
        return [NSString stringWithFormat:@"%2i hour %2i min %2i sec", hours, minutes, seconds];
    }
    else if (minutes > 0)
    {
        return [NSString stringWithFormat:@"%2i min %2i sec", minutes, seconds];
    }
    else
    {
        return [NSString stringWithFormat:@"%2i sec", seconds];
    }
    
    return @"";
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
//    @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
//    NSString *body = @"&body=It is raining in sunny California!";
//    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
//    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
//
//
+(void)launchMailAppOnDevice:(NSString*)toRecipients cc:(NSString*) ccRecipients bcc:(NSString*) bccRecipients subject:(NSString*)subjectStr body:(NSString*) bodyStr
{
    NSString *email = [[NSString alloc] initWithFormat:@"mailto:%@?cc=%@&bcc=%@&subject=%@&body=%@",toRecipients, ccRecipients,bccRecipients,subjectStr,bodyStr];
    
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

@end
