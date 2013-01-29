//
//  AddEquipmentViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/17/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentUpdate.h"

@interface AddEquipmentViewController : UITableViewController <EquipmentUpdate>
@property (nonatomic,strong) NSDictionary* addEquipmentDetail;
@end
