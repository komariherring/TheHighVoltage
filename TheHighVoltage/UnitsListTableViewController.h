//
//  UnitsListTableViewController.h
//  TheHighVoltage
//
//  Created by Komari Herring on 10/5/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighVoltageTableViewController.h" 

@interface UnitsListTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *units;
@property (strong, nonatomic) id<UnitsListDelegate> delegate;




@end
