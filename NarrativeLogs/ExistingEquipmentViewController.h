//
//  ExistingEquipmentViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/28/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentUpdate.h"

@interface ExistingEquipmentViewController : UITableViewController
@property (nonatomic, strong) NSArray* equipment;
@property (nonatomic, strong) id<EquipmentUpdate> equipementUpdateDelegate;

@end
