//
//  Brain.h
//  TheHighVoltage
//
//  Created by Komari Herring on 10/5/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brain : NSObject

typedef enum
{
    OperatorTypeNone,
    OperatorTypeSome,
    OperatorTypeAddition,
    OperatorTypeSubtraction,
    OperatorTypeMultiplication,
    OperatorTypeDivision,
    OperatorTypeWattsOhms,
    OperatorTypeWattsAmps,
    OperatorTypeWattsVolts,
    OperatorTypeOhmsAmps,
    OperatorTypeOhmsVolts,
    OperatorTypeOhmsWatts,
    OperatorTypeVoltsAmps,
    OperatorTypeVoltsWatts,
    OperatorTypeVoltsOhms,
    OperatorTypeAmpsOhms,
    OperatorTypeAmpsVolts,
    OperatorTypeAmpsWatts
}   OperatorType;

@property (strong, nonatomic) NSMutableArray *brainAnswers;
@property (strong, nonatomic) NSString *voltsAsAString;
@property (strong, nonatomic) NSString *wattsAsAString;
@property (strong, nonatomic) NSString *ohmsAsAString;
@property (strong, nonatomic) NSString *ampsAsAString;
@property double voltsAsADouble;
@property double wattsAsADouble;
@property double ohmsAsADouble;
@property double ampsAsADouble;
@property (nonatomic, assign)enum OperatorType *thisOperator;

- (NSString *)addOperandDigit:(NSString *)digit;
- (NSString *)addOperator:(NSString *)operatorValue;
- (NSString *)performCalculationIfPossible;
- (int) getReturnCount:(int)rCount;



@end
