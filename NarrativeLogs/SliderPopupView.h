//
//  SliderPopupView.h
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//
// Code taken and modified from
// https://github.com/mneuwert/iOS-Custom-Controls

#import <UIKit/UIKit.h>

@interface SliderPopupView : UIView
@property (nonatomic, retain) NSString *unit;
@property (nonatomic) float value;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) NSString *text;
@end
