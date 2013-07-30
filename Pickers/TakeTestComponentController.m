//
//  TakeTestComponentController.m
//  FGM
//
//  Created by Dave Mark on 8/17/11.
//  Copyright (c) 2011 Dave Mark. All rights reserved.
//
#import "Constants.h"
#import "TakeTestComponentController.h"
#import "MathUIControlObject.h"
#import "MathTableDataObject.h"
#import "Utility.h"
#import "MathUtility.h"
#import "MathScore.h"
#import "CHCircularBuffer.h"

@implementation TakeTestComponentController

@synthesize mathTableDataObjectArr;
@synthesize mathScore;
@synthesize totalCorrectAnswers;

@synthesize curIndex;
@synthesize userEnteredNumber;

@synthesize mathUiControlObject;

@synthesize stepper;
@synthesize shuffleSwitch;
@synthesize segmentControl;
@synthesize  r1c1, r1op, r1c2, r1c3;

//
// when operand (add, sub, mul, div) is changed, set the value at application level, and reset the data
//
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
    [self resetData];
}

//
// when shuffle options is changed, set the value at application level, and reset the data
//
- (IBAction)shufflePressed:(UISwitch*)sender
{
    [Utility setShuffleNumbers:sender.on];
    [self resetData];
}

//
// when stepper is changed to increment or decrement numbers, set the value at application level, and reset the data
//
- (IBAction)stepperPressed:(UIStepper *)sender
{
    double value = [sender value];
    [Utility setCurrentNumber:(int) value];
    [self resetData];
}

//
// when number is pressed, capture it in userEnteredNumber field,
// and also bind it to the UI control
//
- (IBAction)numberButtonPressed:(UIButton *)sender
{
    if([userEnteredNumber length] >= 3)
    {
        [self markAsWrongAnswer];
        return;
    }
    
    [userEnteredNumber appendFormat:@"%d",sender.tag];
    [mathUiControlObject.resultNumberLabel setText:userEnteredNumber];
    mathUiControlObject.resultNumberLabel.textColor = [UIColor blackColor];
}

//
// when clear button is pressed, clear the userEnteredNumber field
//
- (IBAction)clrButtonPressed:(UIButton *)sender
{
    [userEnteredNumber setString:@""];
    [mathUiControlObject.resultNumberLabel setText:@""];
}

//
// mark current answer as wrong
// > color it red
// > set it as wrong in the mathscore object
// > for next text entry, clear the previous data in label
//
- (void)markAsWrongAnswer
{
    // update score as wrong answer
    [mathScore setAnswerAtIndex:curIndex withAnswerType:kQnAWrongAnswer];
    
    mathUiControlObject.resultNumberLabel.textColor = [UIColor redColor];
    [userEnteredNumber setString:@""];
}

//
// handle go button
//
- (IBAction)goButtonPressed:(UIButton *)sender
{    
    int actualResultInt = [(MathTableDataObject *)[mathTableDataObjectArr objectAtIndex:curIndex] resultNumber];
    int userEnteredNumberInt = [userEnteredNumber intValue];

    if(actualResultInt != userEnteredNumberInt)
    {
        [self markAsWrongAnswer];
        return;
    }

    if([mathScore answerAtIndex:curIndex] == kQnANotAttempted)
    {
        // update score as correct answer
        [mathScore setAnswerAtIndex:curIndex withAnswerType:kQnACorrectAnswer];
        totalCorrectAnswers++;
    }
    
    mathUiControlObject.resultNumberLabel.textColor = [UIColor blackColor];

    [userEnteredNumber setString:@""];
    
    curIndex++;
    if(curIndex >= 10)
    {
        CHCircularBuffer* circularBuffer = [Utility getMathScores];
        [circularBuffer insertObject:mathScore atIndex:0];
//        [circularBuffer addObject:mathScore];
        [Utility setMathScores:circularBuffer];
        
        NSString* tmpKudosString;
        
        if(totalCorrectAnswers >= 9)
        {
            tmpKudosString = @"Great job";
        }
        else if (totalCorrectAnswers >= 7)
        {
            tmpKudosString = @"Good job";
        }
        else if (totalCorrectAnswers >= 5)
        {
            tmpKudosString = @"Good try";
        }
        else
        {
            tmpKudosString = @"Keep working";
        }

        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:tmpKudosString
                              message:[[NSString alloc]initWithFormat:@"%d/%d correct", totalCorrectAnswers, [Utility getMaxNumberArraySize]]
                              delegate:nil
                              cancelButtonTitle:@"Done"
                              otherButtonTitles:nil];
        [alert show];
        
//        [mathScore print];
        
        [self resetData];
        return;
    }
    
    // use existing data object 
    [self bindData];

}

//
// reset the data. includes getting fresh data and also the current index to data array is resetted
//
- (void)resetData
{
    curIndex = 0;
    totalCorrectAnswers = 0;
    
    // get new data from utility method, and store in local object 
    mathTableDataObjectArr = [MathUtility getMathTableDataObjectArray];
    
    // initialize score object
    mathScore = [[MathScore alloc] initWithMathTableObjectArray:mathTableDataObjectArr];

    [self bindData];
}

//
// bind the data in dataObj to the UI elements
//
- (void)bindData
{
    NSString* tmpStr = nil;
    
    MathTableDataObject* mathTableDataObject = (MathTableDataObject*)[mathTableDataObjectArr objectAtIndex:curIndex];
    
    tmpStr = [NSString stringWithFormat:@"%d", mathTableDataObject.firstNumber];
    [mathUiControlObject.firstNumberLabel setText: tmpStr];
    tmpStr = [NSString stringWithFormat:@"%d", mathTableDataObject.secondNumber];
    [mathUiControlObject.secondNumberLabel setText: tmpStr];
    tmpStr = [MathUtility getOperandSymbol:mathTableDataObject.operand];
    [mathUiControlObject.operandLabel setText: tmpStr];

    // hide the answer
    [mathUiControlObject.resultNumberLabel setText:@""];
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
- (void)viewDidAppear:(BOOL)animated
{
    // initialize enteredResult
    userEnteredNumber = [[NSMutableString alloc] init];
    
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
    
    // top label object
    mathUiControlObject = [[MathUIControlObject alloc] init];
    mathUiControlObject.firstNumberLabel  = r1c1;
    mathUiControlObject.secondNumberLabel = r1c2;
    mathUiControlObject.operandLabel      = r1op;
    mathUiControlObject.resultNumberLabel = r1c3;
    
    // reset the data object (array) to be used for the flow
    [self resetData];
    
    [super viewDidAppear:animated];
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
