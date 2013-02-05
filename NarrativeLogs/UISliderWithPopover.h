//
//  UISliderWithPopover.h
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//
// Code taken and modified from
// https://github.com/mneuwert/iOS-Custom-Controls

#import <UIKit/UIKit.h>
#import "SliderPopupView.h"
@interface UISliderWithPopover : UISlider
@property (nonatomic, retain) SliderPopupView * popupView;
@property (nonatomic) CGRect thumbRect;
@property (nonatomic, retain) NSString *unit;
@end
