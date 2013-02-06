//
//  PlantParameterViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RangePickerPopoverDelegate.h"

@interface PlantParameterViewController : UITableViewController <RangePickerPopoverDelegate>
@property (nonatomic, strong) NSMutableDictionary* plantParameters;
@end
