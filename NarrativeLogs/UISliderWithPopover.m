//
//  UISliderWithPopover.m
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//
// Code taken and modified from
// https://github.com/mneuwert/iOS-Custom-Controls

#import "UISliderWithPopover.h"

@implementation UISliderWithPopover
@synthesize thumbRect = _thumbRect;
@synthesize popupView = _popupView;
@synthesize unit = _unit;

#pragma mark - Private methods

- (void) constructSlider {
    self.popupView = [[SliderPopupView alloc] initWithFrame:CGRectZero];
    self.popupView.backgroundColor = [UIColor clearColor];
    self.popupView.alpha = 0.0;
    [self addSubview:self.popupView];
}

- (void) fadePopupViewInAndOut:(BOOL)aFadeIn {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if (aFadeIn) {
        self.popupView.alpha = 1.0;
    } else {
        self.popupView.alpha = 0.0;
    }
    [UIView commitAnimations];
}

- (void) positionAndUpdatePopupView {
    CGRect popupRect = CGRectOffset(self.thumbRect, 0, -floorf(self.thumbRect.size.height * 1.0));
    self.popupView.frame = CGRectInset(popupRect, -20, -10);
    self.popupView.value = self.value;
    self.popupView.unit = self.unit;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self  constructSlider];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self  constructSlider];
    }
    return self;
}

#pragma mark - UIControl touch event tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL success = [super beginTrackingWithTouch:touch withEvent:event];
    // Fade in and update the popup view
    CGPoint touchPoint = [touch locationInView:self];
    // Check if the knob is touched. Only in this case show the popup-view
    if(CGRectContainsPoint(CGRectInset(self.thumbRect, -12.0, -12.0), touchPoint)) {
        [self positionAndUpdatePopupView];
        [self fadePopupViewInAndOut:YES];
    }
    return success;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Update the popup view as slider knob is being moved
    BOOL success = [super continueTrackingWithTouch:touch withEvent:event];
    [self positionAndUpdatePopupView];
    return success;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Fade out the popoup view
    [self fadePopupViewInAndOut:NO];
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Custom property accessors

- (CGRect)thumbRect {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbR = [self thumbRectForBounds:self.bounds
                                   trackRect:trackRect
                                       value:self.value];
    NSLog(@"raw value of the slider %f", self.value);
    return thumbR;
}

@end
