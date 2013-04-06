//
//  Constants.h
//  FGM
//
//  Created by Vijayant Palaiya on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef DEBUG

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define D2Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


@interface Constants : NSObject

#define kADD_OP         @"ADD"
#define kSUB_OP         @"SUB"
#define kMUL_OP         @"MUL"
#define kDIV_OP         @"DIV"

#define kADD_OP_SYM     @"+"
#define kSUB_OP_SYM     @"-"
#define kMUL_OP_SYM     @"x"
#define kDIV_OP_SYM     @"/" // \u00F7

#define kDefaultCurrentNumber            1
#define kDefaultMaxNumberArraySize       10
#define kDefaultCurrentOperation         kADD_OP
#define kDefaultShuffleNumbers           false
#define kDefaultShuffleOperations        false

//
// Constants for custom application data stored in archive file
//

// name of the archive file which store custom application data
#define kCustomAppArchiveFilename    @"archive" 

// key of the root data (for custom application data) that is stored in the archive file
#define kCustomAppDataKey            @"Data" 


@end
