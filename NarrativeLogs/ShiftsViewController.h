//
//  ShiftsViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/8/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiftsViewController : UITableViewController
@property (nonatomic, strong) NSArray* shifts;
- (void) loadShifts:(id)sender;
@end
