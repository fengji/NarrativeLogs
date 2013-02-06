//
//  RangePickerPopoverDelegate.h
//  NarrativeLogs
//
//  Created by Feng Ji on 2/5/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RangePickerPopoverDelegate <NSObject>
- (void) dismissPopover;
- (void) updateRangeWithStart:(NSString*) start End: (NSString*) end;
@end
