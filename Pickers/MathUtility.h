//
//  MathUtility.h
//

#import <Foundation/Foundation.h>

@class MathTableDataObject;

@interface MathUtility : NSObject

+ (NSMutableArray*) getFirstNumberArray;
+ (NSMutableArray*) getSecondNumberArray;
+ (NSMutableArray*) getOperandArray;
+ (NSMutableArray*) getMathUIObjectArray;
+ (NSMutableArray*) getMathScoreObjectArray;
+ (NSString*) getOperandSymbol: (NSString *) operandName;
+ (NSMutableArray*) getRandomNumberArray: (int) size;

@end
