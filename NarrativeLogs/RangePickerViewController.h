//
//  RangePickerViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 2/5/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RangePickerPopoverDelegate.h"
@interface RangePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSArray * data1;
@property (nonatomic, strong) NSArray * data2;
@property (nonatomic, strong) id<RangePickerPopoverDelegate> rangePickerPopoverDelegate;
@end
