//
//  BaseTableComponentController.m
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//
#import "Constants.h"
#import "BaseTableComponentController.h"
#import "MathUIControlObject.h"
#import "MathTableDataObject.h"
#import "Utility.h"
#import "MathUtility.h"

@implementation BaseTableComponentController

@synthesize stepper;
@synthesize shuffleSwitch;
@synthesize segmentControl;
@synthesize  r1c1, r2c1, r3c1, r4c1, r5c1, r6c1, r7c1, r8c1, r9c1, r10c1;
@synthesize  r1op, r2op, r3op, r4op, r5op, r6op, r7op, r8op, r9op, r10op;
@synthesize  r1c2, r2c2, r3c2, r4c2, r5c2, r6c2, r7c2, r8c2, r9c2, r10c2;
@synthesize  r1c3, r2c3, r3c3, r4c3, r5c3, r6c3, r7c3, r8c3, r9c3, r10c3;
@synthesize  r1btn, r2btn, r3btn, r4btn, r5btn, r6btn, r7btn, r8btn, r9btn, r10btn;
@synthesize  mathUiControlObjectArr;

- (BOOL)showTapButton
{
    return NO;
}

- (IBAction)toggleOperand:(id)sender
{
    NSString* tmpStr;
    if ([sender selectedSegmentIndex] == 0) // ADD
    {
        tmpStr = kADD_OP;
    }
    else if ([sender selectedSegmentIndex] == 1) // SUB
    {
        tmpStr = kSUB_OP;
    }
    else if ([sender selectedSegmentIndex] == 2) // MUL
    {
        tmpStr = kMUL_OP;
    }
    else if ([sender selectedSegmentIndex] == 3) // DIV
    {
        tmpStr = kDIV_OP;
    }
    
    [Utility setCurrentOperation:tmpStr];
    [self bindData:[MathUtility getMathUIObjectArray]];
    
}

- (IBAction)shufflePressed:(UISwitch*)sender
{
    [Utility setShuffleNumbers:sender.on];
    [self bindData:[MathUtility getMathUIObjectArray]];
}

- (IBAction)stepperPressed:(UIStepper *)sender
{
    double value = [sender value];
    [Utility setCurrentNumber:(int) value];
    [self bindData:[MathUtility getMathUIObjectArray]];
}

- (IBAction)tapButtonPressed:(UIButton *)sender
{
    [sender setHidden:YES];
}

- (void)bindData:(NSMutableArray*) dataObj
{
    NSString* tmpStr = nil;
    int maxSize = [Utility getMaxNumberArraySize];
    
    MathTableDataObject* mathTableDataObject = nil;
    MathUIControlObject* mathUiControlObject = nil;
    for(int i = 0; i < maxSize; i++)
    {
        mathTableDataObject = (MathTableDataObject*)[dataObj objectAtIndex:i];
        mathUiControlObject = (MathUIControlObject*)[mathUiControlObjectArr objectAtIndex:i];
        
        tmpStr = [NSString stringWithFormat:@"%d", mathTableDataObject.firstNumber];
        [mathUiControlObject.firstNumberLabel setText: tmpStr];
        tmpStr = [NSString stringWithFormat:@"%d", mathTableDataObject.secondNumber];
        [mathUiControlObject.secondNumberLabel setText: tmpStr];
        tmpStr = [MathUtility getOperandSymbol:mathTableDataObject.operand];
        [mathUiControlObject.operandLabel setText: tmpStr];
        tmpStr = [NSString stringWithFormat:@"%d", mathTableDataObject.resultNumber];
        [mathUiControlObject.resultNumberLabel setText: tmpStr];
        [mathUiControlObject.tapButton setHidden:!(self.showTapButton)];
    }
}

- (id)init
{
    D2Log(@"init called");
    return [super init];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    D2Log(@"initWithNibName called");

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int maxSize = [Utility getMaxNumberArraySize];

    // initialize stepper control
    stepper.value = (double)[Utility getCurrentNumber];
    
    // initialize switch control
    shuffleSwitch.on = [Utility getShuffleNumbers] ;
    
    // initialize segment control
    if([[Utility getCurrentOperation] isEqualToString:kADD_OP])
    {
        segmentControl.selectedSegmentIndex = 0;
    }
    else if([[Utility getCurrentOperation] isEqualToString:kSUB_OP])
    {
        segmentControl.selectedSegmentIndex = 1;
    }
    else if([[Utility getCurrentOperation] isEqualToString:kMUL_OP])
    {
        segmentControl.selectedSegmentIndex = 2;
    }
    else if([[Utility getCurrentOperation] isEqualToString:kDIV_OP])
    {
        segmentControl.selectedSegmentIndex = 3;
    }
    
    // TODO - assumption is that there are only 10 numbers supported.
    // TODO - use ivar or similar approach to initialize label array. using obj c introspection / reflection method
    
    mathUiControlObjectArr = [[NSMutableArray alloc] initWithCapacity:maxSize];
    
    MathUIControlObject* mathUiControlObject = nil;
    
    // 1st object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r1c1;
    mathUiControlObject.secondNumberLabel = r1c2;
    mathUiControlObject.operandLabel      = r1op;
    mathUiControlObject.resultNumberLabel = r1c3;
    mathUiControlObject.tapButton         = r1btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 2nd object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r2c1;
    mathUiControlObject.secondNumberLabel = r2c2;
    mathUiControlObject.operandLabel      = r2op;
    mathUiControlObject.resultNumberLabel = r2c3;
    mathUiControlObject.tapButton         = r2btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 3rd object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r3c1;
    mathUiControlObject.secondNumberLabel = r3c2;
    mathUiControlObject.operandLabel      = r3op;
    mathUiControlObject.resultNumberLabel = r3c3;
    mathUiControlObject.tapButton         = r3btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 4th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r4c1;
    mathUiControlObject.secondNumberLabel = r4c2;
    mathUiControlObject.operandLabel      = r4op;
    mathUiControlObject.resultNumberLabel = r4c3;
    mathUiControlObject.tapButton         = r4btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 5th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r5c1;
    mathUiControlObject.secondNumberLabel = r5c2;
    mathUiControlObject.operandLabel      = r5op;
    mathUiControlObject.resultNumberLabel = r5c3;
    mathUiControlObject.tapButton         = r5btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 6th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r6c1;
    mathUiControlObject.secondNumberLabel = r6c2;
    mathUiControlObject.operandLabel      = r6op;
    mathUiControlObject.resultNumberLabel = r6c3;
    mathUiControlObject.tapButton         = r6btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 7th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r7c1;
    mathUiControlObject.secondNumberLabel = r7c2;
    mathUiControlObject.operandLabel      = r7op;
    mathUiControlObject.resultNumberLabel = r7c3;
    mathUiControlObject.tapButton         = r7btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 8th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r8c1;
    mathUiControlObject.secondNumberLabel = r8c2;
    mathUiControlObject.operandLabel      = r8op;
    mathUiControlObject.resultNumberLabel = r8c3;
    mathUiControlObject.tapButton         = r8btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 9th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r9c1;
    mathUiControlObject.secondNumberLabel = r9c2;
    mathUiControlObject.operandLabel      = r9op;
    mathUiControlObject.resultNumberLabel = r9c3;
    mathUiControlObject.tapButton         = r9btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    // 10th object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r10c1;
    mathUiControlObject.secondNumberLabel = r10c2;
    mathUiControlObject.operandLabel      = r10op;
    mathUiControlObject.resultNumberLabel = r10c3;
    mathUiControlObject.tapButton         = r10btn;
    [mathUiControlObjectArr addObject:mathUiControlObject];
    
    
    [self bindData:[MathUtility getMathUIObjectArray]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //    self.singlePicker = nil;
    //    self.pickerData = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
