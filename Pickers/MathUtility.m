//
//  MathUtility.m
//

#import "MathUtility.h"
#import "Utility.h"
#import "Constants.h"
#import "MathTableDataObject.h"

@implementation MathUtility

+ (NSMutableArray*) getFirstNumberArray
{
    int curNum = [Utility getCurrentNumber];
    int maxSize = [Utility getMaxNumberArraySize];
    
    NSMutableArray* retArr = [[NSMutableArray alloc] initWithCapacity:maxSize];
    for(int i = 0; i < maxSize; i++)
    {
        [retArr addObject:[NSNumber numberWithInteger:curNum]];
    }
    
    return retArr;
}

+ (NSMutableArray*) getSecondNumberArray
{
    BOOL shufNums = [Utility getShuffleNumbers];
    int maxSize = [Utility getMaxNumberArraySize];
    
    NSMutableArray* retArr;
    
    if(shufNums)
    {
        // get randoms numbers
        retArr = [MathUtility getRandomNumberArray:maxSize];
    }
    else
    {
        retArr = [[NSMutableArray alloc] initWithCapacity:maxSize];

        for(int i = 0; i < maxSize; i++)
        {
            [retArr addObject:[NSNumber numberWithInteger:(i+1)]];
        }
        
    }
    
    return retArr;
}

+ (NSMutableArray*) getOperandArray
{
    BOOL shufOps = [Utility getShuffleOperations];
    int maxSize = [Utility getMaxNumberArraySize];
    NSString* opStr = [Utility getCurrentOperation];
    
    NSMutableArray* retArr = [[NSMutableArray alloc] initWithCapacity:maxSize];
    
    shufOps = false; // TODO temporary
    
    if(shufOps)
    {
        // do something TODO
        // get randoms operands
    }
    else
    {
        for(int i = 0; i < maxSize; i++)
        {
            [retArr addObject:opStr];
        }
        
    }
    
    return retArr;
    
}


+ (NSMutableArray*) getMathUIObjectArray
{
    NSMutableArray* firstNumberArr  = [MathUtility getFirstNumberArray];
    NSMutableArray* secondNumberArr = [MathUtility getSecondNumberArray];
    NSMutableArray* operandArr      = [MathUtility getOperandArray];
    
    MathTableDataObject* mathTableDataObject = nil;
    int firstNumber = -1;
    int secondNumber = -1;
    int resultNumber = -1;
    NSString* operand = nil;
    
    int maxSize = [Utility getMaxNumberArraySize];
    NSMutableArray* retArr = [[NSMutableArray alloc] initWithCapacity:maxSize];
    for(int i = 0; i < maxSize; i++)
    {
        firstNumber = [[firstNumberArr objectAtIndex:i] integerValue];
        secondNumber = [[secondNumberArr objectAtIndex:i] integerValue];
        operand = [operandArr objectAtIndex:i];
        
        if([operand isEqualToString:kADD_OP])
        {
            resultNumber = firstNumber + secondNumber;
        }
        else if([operand isEqualToString:kMUL_OP])
        {
            resultNumber = firstNumber * secondNumber;
        }
        else if([operand isEqualToString:kSUB_OP])
        {
            firstNumber = firstNumber + secondNumber;
            secondNumber = [[firstNumberArr objectAtIndex:i] integerValue];
            resultNumber = firstNumber - secondNumber;
        }
        else if([operand isEqualToString:kDIV_OP])
        {
            firstNumber = firstNumber * secondNumber;
            secondNumber = [[firstNumberArr objectAtIndex:i] integerValue];
            resultNumber = firstNumber / secondNumber;
        }
        
        mathTableDataObject = [[MathTableDataObject alloc] init];
        mathTableDataObject.firstNumber  = firstNumber;
        mathTableDataObject.secondNumber = secondNumber;
        mathTableDataObject.operand      = [operandArr objectAtIndex:i];
        mathTableDataObject.resultNumber = resultNumber;
        
        [retArr addObject:mathTableDataObject];
    }
    
    // TODO memory cleanup
    return retArr;
}

+ (NSString*) getOperandSymbol: (NSString *) operandName
{
    if([operandName isEqualToString:kADD_OP])
    {
        return kADD_OP_SYM;
    }
    else if([operandName isEqualToString:kSUB_OP])
    {
        return kSUB_OP_SYM;
    }
    else if([operandName isEqualToString:kMUL_OP])
    {
        return kMUL_OP_SYM;
    }
    else if([operandName isEqualToString:kMUL_OP])
    {
        return kMUL_OP_SYM;
    }
    
    return nil;
}

//
// return an array of size, with random numbers from 1..size
//
+ (NSMutableArray*) getRandomNumberArray: (int) size
{
    NSMutableArray* origArray  = [[NSMutableArray alloc] initWithCapacity:size];
    NSMutableArray* newArray  = [[NSMutableArray alloc] initWithCapacity:size];
    for(int i = 0; i < size; i++)
    {
        [origArray addObject:[NSNumber numberWithInteger:(i+1)]];
        [newArray addObject:[NSNumber numberWithInteger: 0]];
    }

    NSInteger randomNumber;
    for(int i = size; i > 0; i--)
    {
        randomNumber = arc4random() % i;
        int tmpInt = [[origArray objectAtIndex:randomNumber] integerValue];
        [origArray removeObjectAtIndex:randomNumber];
        
//        D2Log("init i=%d, value=%d", (i-1), tmpInt);

        [newArray removeObjectAtIndex:(i-1)];
        [newArray insertObject:[NSNumber numberWithInteger:tmpInt] atIndex:(i-1)];
    }
    
//    D2Log("random array size=%d", [newArray count]);
//    for(int i = 0; i < size; i++)
//    {
//        D2Log("i= %d, %@", i, [[newArray objectAtIndex:i] stringValue]);
//    }
    
    return newArray;
}

@end
