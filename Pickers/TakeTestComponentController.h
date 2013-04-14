//
//  BIDSingleComponentPickerViewController.h
//  Pickers
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MathUIControlObject;

@interface TakeTestComponentController : UIViewController

// data object (array) that will be used in the flow and displayed in the UI
@property (strong, nonatomic) NSMutableArray* mathUiDataObjectArr;

// current index into the data object array. data object array contains the multiple questions asked
@property (nonatomic) int curIndex;

// this field holds the entered numbers that the user would input in the UI
@property (strong,nonatomic) NSMutableString* userEnteredNumber;

// UI object structure to hold the UI controls for the top question and answer UI
@property (strong,nonatomic) MathUIControlObject* mathUiControlObject;


@property (strong, nonatomic) IBOutlet UIStepper  *stepper;
@property (strong, nonatomic) IBOutlet UISegmentedControl  *segmentControl;
@property (strong, nonatomic) IBOutlet UISwitch  *shuffleSwitch;

@property (strong, nonatomic) IBOutlet UILabel  *r1c1, *r1op, *r1c2, *r1c3;
@property (strong, nonatomic) IBOutlet UIButton *num0btn, *num1btn, *num2btn, *num3btn, *num4btn, *num5btn, *num6btn, *num7btn, *num8btn, *num9btn;

- (IBAction)toggleOperand:(id)sender;
- (IBAction)shufflePressed:(UISwitch*)sender;
- (IBAction)stepperPressed:(UIStepper *)sender;
- (IBAction)numberButtonPressed:(UIButton *)sender;
- (IBAction)clrButtonPressed:(UIButton *)sender;
- (IBAction)goButtonPressed:(UIButton *)sender;

@end
