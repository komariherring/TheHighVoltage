//
//  Brain.m
//  TheHighVoltage
//
//  Created by Komari Herring on 10/5/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "Brain.h"


@interface Brain ()

@property (nonatomic, copy) NSMutableString *operand1String;
@property (nonatomic, copy) NSMutableString *operand2String;
@property int brainCount;

@property (assign) OperatorType operatorType;

@end

@implementation Brain

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];
        _operatorType = OperatorTypeNone;
    }
    
    return self;
}

- (int) getReturnCount:(int)rCount
{
    self.brainCount = rCount;
    return self.brainCount;
}

- (NSString *)addOperandDigit:(NSString *)digit
{
    NSString *returnString;
    
    if (self.brainCount == 0)
    {
        if ([digit isEqualToString:@"."])
        {
            if (![self.operand1String containsString:@"."])
            {
                [self.operand1String appendString:@"."];
            }
        }
        else
        {
            [self.operand1String appendString:digit];
        }
        
        returnString = self.operand1String;
        
        
    }
    else if (self.brainCount == 1)
    {
        if ([digit isEqualToString:@"."])
        {
            if (![self.operand2String containsString:@"."])
            {
                [self.operand2String appendString:@"."];
            }
        }
        else
        {
            [self.operand2String appendString:digit];
        }
        returnString = self.operand2String;
    }
    
    NSLog(@"operand1String is %@", self.operand1String);
    NSLog(@"operand2String is %@", self.operand2String);
    
    
    return returnString;
    
}

- (NSString *)addOperator:(NSString *)operatorValue
{
    NSString *returnString = nil;
    
    if (self.operatorType == OperatorTypeNone )
    {
        
        if ([operatorValue containsString:@"Volts"] && [operatorValue containsString:@"Watts"])
        {
            if ([operatorValue isEqualToString:@"VoltsWatts"])
            {
                self.operatorType = OperatorTypeVoltsWatts;
            }
            else
            {
                self.operatorType = OperatorTypeWattsVolts;
            }
            
        }
        else if ([operatorValue containsString:@"Volts"] && [operatorValue containsString:@"Ohms"])
        {
            if ([operatorValue isEqualToString:@"VoltsOhms"])
            {
                self.operatorType = OperatorTypeVoltsOhms;
            }
            else
            {
                self.operatorType = OperatorTypeOhmsVolts;
            }
        }
        else if ([operatorValue containsString:@"Volts"] && [operatorValue containsString:@"Amps"])
        {
            if ([operatorValue isEqualToString:@"VoltsAmps"])
            {
                self.operatorType = OperatorTypeVoltsAmps;
            }
            else
            {
                self.operatorType = OperatorTypeAmpsVolts;
            }
        }
        else if ([operatorValue containsString:@"Ohms"] && [operatorValue containsString:@"Amps"])
        {
            if ([operatorValue isEqualToString:@"OhmsAmps"])
            {
                self.operatorType = OperatorTypeOhmsAmps;
            }
            else
            {
                self.operatorType = OperatorTypeAmpsOhms;
            }
        }
        else if ([operatorValue containsString:@"Ohms"] && [operatorValue containsString:@"Watts"])
        {
            if ([operatorValue isEqualToString:@"OhmsWatts"])
            {
                self.operatorType = OperatorTypeOhmsWatts;
            }
            else
            {
                self.operatorType = OperatorTypeWattsOhms;
            }
        }
        else if ([operatorValue containsString:@"Amps"] && [operatorValue containsString:@"Watts"])
        {
            if ([operatorValue isEqualToString:@"AmpsWatts"])
            {
                self.operatorType = OperatorTypeAmpsWatts;
            }
            else
            {
                self.operatorType = OperatorTypeWattsAmps;
            }
        }
        
        
        
        
    }
    
    NSLog(@"OpType is %u", self.operatorType);
    
    
    return returnString;
}

- (NSString *)flipSign
{
    if (![self.operand2String isEqualToString:@""])
    {
        double operand = [self.operand2String doubleValue];
        if (operand != 0)
        {
            
            operand = operand * -1;
            [self.operand2String setString:[NSString stringWithFormat:@"%g", operand]];
            return self.operand2String;
        }
    }
    else if (![self.operand1String isEqualToString:@""])
    {
        double operand = [self.operand1String doubleValue];
        if (operand != 0)
        {
            operand = operand * -1;
            [self.operand1String setString:[NSString stringWithFormat:@"%g", operand]];
            return self.operand1String;
        }
    }
    
    return nil;
}

- (NSString *)makePercent
{
    if (![self.operand2String isEqualToString:@""])
    {
        double operand = [self.operand2String doubleValue];
        // Convert number to percentage
        operand = operand * 0.01f;
        [self.operand2String setString:[NSString stringWithFormat:@"%g", operand]];
        return self.operand2String;
    }
    else if (![self.operand1String isEqualToString:@""])
    {
        double operand = [self.operand1String doubleValue];
        // Convert number to percentage
        operand = operand * 0.01f;
        [self.operand1String setString:[NSString stringWithFormat:@"%g", operand]];
        return self.operand1String;
    }
    
    return nil;
}

- (NSString *)performSquareRoot
{
    if (![self.operand2String isEqualToString:@""])
    {
        double operand = [self.operand2String doubleValue];
        if (operand >= 0)
        {
            operand = sqrt(operand);
            [self.operand2String setString:[NSString stringWithFormat:@"%g", operand]];
            return self.operand2String;
        }
        else
        {
            return @"Error";
        }
    }
    else if (![self.operand1String isEqualToString:@""])
    {
        double operand = [self.operand1String doubleValue];
        if (operand >= 0)
        {
            operand = sqrt(operand);
            [self.operand1String setString:[NSString stringWithFormat:@"%g", operand]];
            return self.operand1String;
        }
        else
        {
            return @"Error";
        }
    }
    
    return nil;
}

- (NSString *)performCalculationIfPossible
{
    
    if (![self.operand1String isEqualToString:@""] && ![self.operand2String isEqualToString:@""] && self.operatorType != OperatorTypeNone)
    {
        double operand1 = [self.operand1String doubleValue];
        double operand2 = [self.operand2String doubleValue];
        
        double answer1 = 0;
        double answer2 = 0;
        
        switch (self.operatorType)
        {
                
            case OperatorTypeWattsOhms:
                self.voltsAsADouble = sqrt(operand1 * operand2);
                self.ampsAsADouble = sqrt(operand1 / operand2);
                self.wattsAsADouble = operand1;
                self.ohmsAsADouble = operand2;
                break;
            case OperatorTypeWattsAmps:
                self.ohmsAsADouble = operand1 / (operand2 * operand2);
                self.voltsAsADouble = operand1 / operand2;
                self.wattsAsADouble = operand1;
                self.ampsAsADouble = operand2;
                break;
            case OperatorTypeWattsVolts:
                self.ampsAsADouble = operand1 / operand2;
                self.ohmsAsADouble = (operand2 * operand2) / operand1;
                self.wattsAsADouble = operand1;
                self.voltsAsADouble = operand2;
                break;
            case OperatorTypeOhmsAmps:
                self.voltsAsADouble = operand2 * operand1;
                self.wattsAsADouble = (operand2 * operand2) * operand1;
                self.ohmsAsADouble = operand1;
                self.ampsAsADouble = operand2;
                break;
            case OperatorTypeOhmsVolts:
                self.wattsAsADouble = (operand2 * operand2) / operand1;
                self.ampsAsADouble = operand2 / operand1;
                self.ohmsAsADouble = operand1;
                self.voltsAsADouble = operand2;
                break;
            case OperatorTypeOhmsWatts:
                self.ampsAsADouble = sqrt(operand2 / operand1);
                self.voltsAsADouble = sqrt(operand2 * operand1);
                self.ohmsAsADouble = operand1;
                self.wattsAsADouble = operand2;
                break;
            case OperatorTypeVoltsAmps:
                self.wattsAsADouble = operand1 * operand2;
                self.ohmsAsADouble = operand1 / operand2;
                self.voltsAsADouble = operand1;
                self.ampsAsADouble = operand2;
                break;
            case OperatorTypeVoltsOhms:
                self.wattsAsADouble = (operand1 * operand1) / operand2;
                self.ampsAsADouble = operand1 / operand2;
                self.voltsAsADouble = operand1;
                self.ohmsAsADouble = operand2;
                break;
            case OperatorTypeVoltsWatts:
                self.ohmsAsADouble = (operand1 * operand1) / operand2;
                self.ampsAsADouble = operand2 / operand1;
                self.voltsAsADouble = operand1;
                self.wattsAsADouble = operand2;
                break;
            case OperatorTypeAmpsOhms:
                self.voltsAsADouble = operand1 * operand2;
                self.wattsAsADouble = (operand1 * operand1) * operand2;
                self.ampsAsADouble = operand1;
                self.ohmsAsADouble = operand2;
                break;
            case OperatorTypeAmpsVolts:
                self.wattsAsADouble = operand2 * operand1;
                self.ohmsAsADouble = operand2 / operand1;
                self.ampsAsADouble = operand1;
                self.voltsAsADouble = operand2;
                break;
            case OperatorTypeAmpsWatts:
                self.ohmsAsADouble = operand2 / (operand1 * operand1);
                self.voltsAsADouble = operand2 / operand1;
                self.ampsAsADouble = operand1;
                self.wattsAsADouble = operand2;
                break;
                
                
            case OperatorTypeDivision:
                if (operand2 != 0)
                {
                    answer1 = operand1 / operand2;
                    answer2 = answer1;
                }
                else
                {
                    
                    return @"Error";
                }
                break;
                
            default:
                break;
        }
        self.ampsAsAString = [NSString stringWithFormat:@"%g", self.ampsAsADouble];
        self.voltsAsAString = [NSString stringWithFormat:@"%g", self.voltsAsADouble];
        self.wattsAsAString = [NSString stringWithFormat:@"%g", self.wattsAsADouble];
        self.ohmsAsAString = [NSString stringWithFormat:@"%g", self.ohmsAsADouble];
        
        return [NSString stringWithFormat:@"%g", answer1];
    }
    
   
    return nil;
}




@end
