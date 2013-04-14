//
//  MathUILabelObject.h
//

#import <Foundation/Foundation.h>

@interface MathUIControlObject : NSObject

@property (nonatomic) UILabel* firstNumberLabel;

@property (nonatomic) UILabel* secondNumberLabel;

@property (strong,nonatomic) UILabel* operandLabel;

@property (nonatomic) UILabel* resultNumberLabel;

@property (nonatomic) UIButton* tapButton;

@end
