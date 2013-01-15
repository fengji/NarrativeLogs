//
//  LogDetailViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/11/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewControllerDelegate.h"

@interface LogDetailViewController : UITableViewController 
- (IBAction)backToEntries:(id)sender;
@property (nonatomic, assign) id<ModalViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDictionary * entryDetail;
@property (nonatomic,strong) NSString* entryId;
@end
