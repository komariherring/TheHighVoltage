//
//  Cell.h
//  TheHighVoltage
//
//  Created by Komari Herring on 10/5/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *valueNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end
