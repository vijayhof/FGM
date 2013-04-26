//
//  BaseTableComponentController.h
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MathUIControlObject;

@interface BaseTableComponentController : UIViewController

@property (nonatomic) BOOL showTapButton;

@property (strong, nonatomic) IBOutlet UIStepper  *stepper;
@property (strong, nonatomic) IBOutlet UISegmentedControl  *segmentControl;
@property (strong, nonatomic) IBOutlet UISwitch  *shuffleSwitch;

@property (strong, nonatomic) IBOutlet UILabel  *r1c1, *r2c1, *r3c1, *r4c1, *r5c1, *r6c1, *r7c1, *r8c1, *r9c1, *r10c1;
@property (strong, nonatomic) IBOutlet UILabel  *r1op, *r2op, *r3op, *r4op, *r5op, *r6op, *r7op, *r8op, *r9op, *r10op;
@property (strong, nonatomic) IBOutlet UILabel  *r1c2, *r2c2, *r3c2, *r4c2, *r5c2, *r6c2, *r7c2, *r8c2, *r9c2, *r10c2;
@property (strong, nonatomic) IBOutlet UILabel  *r1c3, *r2c3, *r3c3, *r4c3, *r5c3, *r6c3, *r7c3, *r8c3, *r9c3, *r10c3;

@property (strong, nonatomic) IBOutlet UIButton  *r1btn, *r2btn, *r3btn, *r4btn, *r5btn, *r6btn, *r7btn, *r8btn, *r9btn, *r10btn;

@property (strong, nonatomic) NSMutableArray* mathUiControlObjectArr;

- (IBAction)toggleOperand:(id)sender;
- (IBAction)shufflePressed:(UISwitch*)sender;
- (IBAction)stepperPressed:(UIStepper *)sender;
- (IBAction)tapButtonPressed:(UIButton *)sender;

@end
