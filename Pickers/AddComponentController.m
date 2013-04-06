//
//  BIDSingleComponentPickerViewController.m
//  Pickers
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//
#import "Constants.h"
#import "AddComponentController.h"
#import "MathUILabelObject.h"
#import "MathUIDataObject.h"
#import "Utility.h"
#import "MathUtility.h"

@implementation AddComponentController

@synthesize stepper;
@synthesize shuffleSwitch;
@synthesize segmentControl;
@synthesize  r1c1, r2c1, r3c1, r4c1, r5c1, r6c1, r7c1, r8c1, r9c1, r10c1;
@synthesize  r1op, r2op, r3op, r4op, r5op, r6op, r7op, r8op, r9op, r10op;
@synthesize  r1c2, r2c2, r3c2, r4c2, r5c2, r6c2, r7c2, r8c2, r9c2, r10c2;
@synthesize  r1c3, r2c3, r3c3, r4c3, r5c3, r6c3, r7c3, r8c3, r9c3, r10c3;
@synthesize  mathUiLabelObjectArr;

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
    D2Log(@"shufflePressed: %@", sender.on ? @"ON" : @"OFF");
    [Utility setShuffleNumbers:sender.on];
    [self bindData:[MathUtility getMathUIObjectArray]];
}

- (IBAction)stepperPressed:(UIStepper *)sender
{
    double value = [sender value];
    [Utility setCurrentNumber:(int) value];
    [self bindData:[MathUtility getMathUIObjectArray]];
}

- (void)bindData:(NSMutableArray*) dataObj
{
    NSString* tmpStr = nil;
    int maxSize = [Utility getMaxNumberArraySize];
    
    MathUIDataObject* mathUiDataObject = nil;
    MathUILabelObject* mathUiLabelObject = nil;
    for(int i = 0; i < maxSize; i++)
    {
        mathUiDataObject = (MathUIDataObject*)[dataObj objectAtIndex:i];
        mathUiLabelObject = (MathUILabelObject*)[mathUiLabelObjectArr objectAtIndex:i];
        
        tmpStr = [NSString stringWithFormat:@"%d", mathUiDataObject.firstNumber];
        [mathUiLabelObject.firstNumberLabel setText: tmpStr];
        tmpStr = [NSString stringWithFormat:@"%d", mathUiDataObject.secondNumber];
        [mathUiLabelObject.secondNumberLabel setText: tmpStr];
        tmpStr = [MathUtility getOperandSymbol:mathUiDataObject.operand];
        [mathUiLabelObject.operandLabel setText: tmpStr];
        tmpStr = [NSString stringWithFormat:@"%d", mathUiDataObject.resultNumber];
        [mathUiLabelObject.resultNumberLabel setText: tmpStr];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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
    
    mathUiLabelObjectArr = [[NSMutableArray alloc] initWithCapacity:maxSize];
    
    MathUILabelObject* mathUiLabelObject = nil;
    
    // 1st object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r1c1;
    mathUiLabelObject.secondNumberLabel = r1c2;
    mathUiLabelObject.operandLabel      = r1op;
    mathUiLabelObject.resultNumberLabel = r1c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 2nd object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r2c1;
    mathUiLabelObject.secondNumberLabel = r2c2;
    mathUiLabelObject.operandLabel      = r2op;
    mathUiLabelObject.resultNumberLabel = r2c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 3rd object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r3c1;
    mathUiLabelObject.secondNumberLabel = r3c2;
    mathUiLabelObject.operandLabel      = r3op;
    mathUiLabelObject.resultNumberLabel = r3c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 4th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r4c1;
    mathUiLabelObject.secondNumberLabel = r4c2;
    mathUiLabelObject.operandLabel      = r4op;
    mathUiLabelObject.resultNumberLabel = r4c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 5th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r5c1;
    mathUiLabelObject.secondNumberLabel = r5c2;
    mathUiLabelObject.operandLabel      = r5op;
    mathUiLabelObject.resultNumberLabel = r5c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 6th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r6c1;
    mathUiLabelObject.secondNumberLabel = r6c2;
    mathUiLabelObject.operandLabel      = r6op;
    mathUiLabelObject.resultNumberLabel = r6c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 7th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r7c1;
    mathUiLabelObject.secondNumberLabel = r7c2;
    mathUiLabelObject.operandLabel      = r7op;
    mathUiLabelObject.resultNumberLabel = r7c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 8th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r8c1;
    mathUiLabelObject.secondNumberLabel = r8c2;
    mathUiLabelObject.operandLabel      = r8op;
    mathUiLabelObject.resultNumberLabel = r8c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 9th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r9c1;
    mathUiLabelObject.secondNumberLabel = r9c2;
    mathUiLabelObject.operandLabel      = r9op;
    mathUiLabelObject.resultNumberLabel = r9c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    // 10th object
    mathUiLabelObject = [[MathUILabelObject alloc] init];
    mathUiLabelObject.firstNumberLabel  = r10c1;
    mathUiLabelObject.secondNumberLabel = r10c2;
    mathUiLabelObject.operandLabel      = r10op;
    mathUiLabelObject.resultNumberLabel = r10c3;
    [mathUiLabelObjectArr addObject:mathUiLabelObject];
    
    
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
