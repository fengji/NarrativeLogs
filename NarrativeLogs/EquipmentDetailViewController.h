//
//  EquipmentDetailViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/17/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipmentDetailViewController : UITableViewController
@property (nonatomic,strong) NSDictionary* equipmentDetail;
@property (nonatomic,strong) NSString* equipmentId;
@end
