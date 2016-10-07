//
//  ViewController.h
//  TheHighVoltage
//
//  Created by Komari Herring on 10/5/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnitsListDelegate

- (void)unitWasChosen:(NSString *)unitName;

@end

@interface HighVoltageTableViewController : UITableViewController

@property int returnPressedCount;


@end
