//
//  MathUtility.h
//

#import <Foundation/Foundation.h>

@class MathUIDataObject;

@interface MathUtility : NSObject

+ (NSMutableArray*) getFirstNumberArray;
+ (NSMutableArray*) getSecondNumberArray;
+ (NSMutableArray*) getOperandArray;
+ (NSMutableArray*) getMathUIObjectArray;
+ (NSString*) getOperandSymbol: (NSString *) operandName;
+ (NSMutableArray*) getRandomNumberArray: (int) size;

@end
