//
//  MathTableDataObject.h
//

#import <Foundation/Foundation.h>

@interface MathTableDataObject : NSObject

// array of first numbers
@property (nonatomic) int firstNumber;

// array of second numbers
@property (nonatomic) int secondNumber;

// array of operands
@property (strong,nonatomic) NSString* operand;

// array of result numbers
@property (nonatomic) int resultNumber;

@end
