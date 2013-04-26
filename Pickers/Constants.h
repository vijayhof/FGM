//
//  Constants.h
//  FGM
//
//  Created by Vijayant Palaiya on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// For debug logging, use DLog or D2Log
//
#undef DEBUG

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define D2Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


@interface Constants : NSObject

//
// operands (or operations)
//
#define kADD_OP         @"ADD"
#define kSUB_OP         @"SUB"
#define kMUL_OP         @"MUL"
#define kDIV_OP         @"DIV"

//
// operand (or operation) symbols
//
#define kADD_OP_SYM     @"+"
#define kSUB_OP_SYM     @"-"
#define kMUL_OP_SYM     @"x"
#define kDIV_OP_SYM     @"/" // \u00F7


//
// Default values for some variables - initial number, initial operand, shuffle on/off setting, etc
//
#define kDefaultCurrentNumber            1
#define kDefaultMaxNumberArraySize       10
#define kDefaultCurrentOperation         kADD_OP
#define kDefaultShuffleNumbers           false
#define kDefaultShuffleOperations        false

//
// Constants used for Scoring
//
#define kQnANotAttempted                 @"NOT_ATTEMPTED"
#define kQnACorrectAnswer                @"CORRECT_ANSWER"
#define kQnAWrongAnswer                  @"WRONG_ANSWER"


//
// Constants for custom application data stored in archive file
//

// name of the archive file which store custom application data
#define kCustomAppArchiveFilename    @"archive" 

// key of the root data (for custom application data) that is stored in the archive file
#define kCustomAppDataKey            @"Data" 


@end
