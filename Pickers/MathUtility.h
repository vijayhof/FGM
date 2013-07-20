//
//  MathUtility.h
//

#import <Foundation/Foundation.h>

@class MathTableDataObject;

@interface MathUtility : NSObject

+ (NSMutableArray*) getFirstNumberArray;
+ (NSMutableArray*) getSecondNumberArray;
+ (NSMutableArray*) getOperandArray;
+ (NSMutableArray*) getMathTableDataObjectArray;
//+ (NSMutableArray*) getMathScoreObjectArray;
+ (NSString*) getOperandSymbol: (NSString *) operandName;
+ (NSMutableArray*) getRandomNumberArray: (int) size;

@end
