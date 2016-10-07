//
//  ViewController.m
//  TheHighVoltage
//
//  Created by Komari Herring on 10/5/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "HighVoltageTableViewController.h"
#import "Brain.h"
#import "Cell.h"
#import "HighVoltageTableViewController.h"
#import "UnitsListTableViewController.h"

@interface HighVoltageTableViewController ()
<UIPopoverPresentationControllerDelegate, UnitsListDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Brain *brain;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) NSMutableArray *visibleUnits;
@property (strong, nonatomic) NSMutableArray *remainingUnits;
@property (strong, nonatomic) NSMutableArray *textFieldArray;
@property (strong, nonatomic) NSArray *answerNameLabelsArray;
@property (strong, nonatomic) NSArray *actualAnswersArray;

@property (strong, nonatomic) NSDictionary *allUnits;

@property (strong, nonatomic) UITextField *voltsTextField;
@property (strong, nonatomic) UITextField *wattsTextField;
@property (strong, nonatomic) UITextField *ampsTextField;
@property (strong, nonatomic) UITextField *ohmsTextField;

@property (strong, nonatomic) NSString *voltsString;
@property (strong, nonatomic) NSString *wattsString;
@property (strong, nonatomic) NSString *ampsString;
@property (strong, nonatomic) NSString *ohmsString;

@property (strong, nonatomic) NSMutableString *comboString;


@end

@implementation HighVoltageTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.visibleUnits = [[NSMutableArray alloc] init];
    
    self.allUnits = @{@"Volts": @"Electrical Potential", @"Watts": @"Power", @"Amps": @"Current", @"Ohms": @"Resistance"};
    self.remainingUnits = [[self.allUnits allKeys] mutableCopy];
    self.textFieldArray = [[NSMutableArray alloc] init];
    
    self.comboString = [[NSMutableString alloc] init];
    
    self.returnPressedCount = 0;
    self.answerNameLabelsArray = @[@"Electrical Potential (volts)", @"Power (watts)", @"Current (amps)", @"Resistance (ohms)"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UnitsNamePopoverSegue"])
    {
        UnitsListTableViewController *hVListVC = [segue destinationViewController];
        hVListVC.units = self.remainingUnits;
        hVListVC.popoverPresentationController.delegate = self;
        hVListVC.delegate = self;
        int contentHeight = 44.0f * self.remainingUnits.count;
        hVListVC.preferredContentSize = CGSizeMake(200.0f, contentHeight);
    }

}



#pragma mark UIPopover stuff

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.returnPressedCount < 2)
    {
        return self.visibleUnits.count;
    }
    else
    {
        return self.allUnits.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"HiVoltCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (self.returnPressedCount < 2)
    {
        [cell.valueTextField becomeFirstResponder];
        cell.valueTextField.delegate = self;
        
        NSString *labelNameKey = self.visibleUnits[indexPath.row];
        NSString *labelNameValue = [self.allUnits objectForKey:labelNameKey];
        
        
        cell.valueNameLabel.text = labelNameValue;
        cell.valueTextField.placeholder = labelNameKey;
        
        if ([labelNameKey isEqualToString:@"Volts"])
        {
            self.voltsTextField = cell.valueTextField;
        }
        else if ([labelNameKey isEqualToString:@"Watts"])
        {
            self.wattsTextField = cell.valueTextField;
        }
        else if ([labelNameKey isEqualToString:@"Amps"])
        {
            self.ampsTextField = cell.valueTextField;
        }
        else if ([labelNameKey isEqualToString:@"Ohms"])
        {
            self.ohmsTextField = cell.valueTextField;
        }
    }
    else
    {
        cell.valueNameLabel.text = self.answerNameLabelsArray[indexPath.row];
        cell.valueTextField.text = self.actualAnswersArray[indexPath.row];
    }
    
    return cell;
}



- (IBAction)clearTapped:(UIBarButtonItem *)sender
{
    self.visibleUnits = [[NSMutableArray alloc] init];
    self.allUnits = @{@"Volts": @"Electrical Potential", @"Watts": @"Power", @"Amps": @"Current", @"Ohms": @"Resistance"};
    
    self.remainingUnits = [[self.allUnits allKeys] mutableCopy];
    self.voltsTextField.text = @"";
    self.ampsTextField.text = @"";
    self.ohmsTextField.text = @"";
    self.wattsTextField.text = @"";
    self.returnPressedCount = 0;
    self.comboString = [NSMutableString stringWithFormat:@""];
    
    self.brain = nil;
    [self.tableView reloadData];
}


#pragma mark - CharacterList delegate
-(void)unitWasChosen:(NSString*)unitName
{
    
    [self.visibleUnits addObject:unitName];
    [self.remainingUnits removeObject:unitName];
    if (self.remainingUnits.count == 0)
    {
        [self.addButton setEnabled:NO];
    }
    [self.tableView reloadData];
}

#pragma mark - Calculation Handlers

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.returnPressedCount = self.returnPressedCount + 1;
    
    if (!self.brain) 
    {
        self.brain = [[Brain alloc] init];
        
    }

    if (textField == self.voltsTextField)
    {
        self.voltsString = textField.text;
        [self.comboString appendString:@"Volts"];
    }
    else if (textField == self.wattsTextField)
    {
        self.wattsString = textField.text;
        [self.comboString appendString:@"Watts"];
    }
    else if (textField == self.ampsTextField)
    {
        self.ampsString = textField.text;
        [self.comboString appendString:@"Amps"];
        
    }
    else if (textField == self.ohmsTextField)
    {
        self.ohmsString = textField.text;
        [self.comboString appendString:@"Ohms"];
        
    }

    
    if (self.returnPressedCount < 2)
    {
        [self.brain addOperandDigit: textField.text];
        [self.brain getReturnCount:self.returnPressedCount];
    }
    else
    {
        [self.brain addOperandDigit: textField.text];
        [self.brain getReturnCount:self.returnPressedCount];
    }
    
    if (self.returnPressedCount == 2)
    {
        [self.brain getReturnCount:self.returnPressedCount];
        [self.brain addOperator:self.comboString];
        [self.brain performCalculationIfPossible];
        NSLog(@"amps is %@", self.brain.ampsAsAString);
        NSLog(@"volts is %@", self.brain.voltsAsAString);
        NSLog(@"watts is %@", self.brain.wattsAsAString);
        NSLog(@"ohms is %@", self.brain.ohmsAsAString);
        self.actualAnswersArray = @[self.brain.voltsAsAString, self.brain.wattsAsAString, self.brain.ampsAsAString, self.brain.ohmsAsAString];
        
        [self.tableView reloadData];
    }
    
    NSLog(@"returnPressedCount is : %d", self.returnPressedCount);
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
