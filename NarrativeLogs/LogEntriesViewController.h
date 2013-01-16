//
//  LogEntriesViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewControllerDelegate.h"
@interface LogEntriesViewController : UITableViewController <ModalViewControllerDelegate>
@property (nonatomic, strong) NSArray* logEntries;
@end
