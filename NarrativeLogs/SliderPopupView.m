//
//  SliderPopupView.m
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//
// Code taken and modified from
// https://github.com/mneuwert/iOS-Custom-Controls

#import "SliderPopupView.h"

@implementation SliderPopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@synthesize unit = _unit;
@synthesize value=_value;
@synthesize font=_font;
@synthesize text = _text;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont boldSystemFontOfSize:18];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // Set the fill color
	[[UIColor colorWithWhite:0 alpha:0.8] setFill];
    
    // Create the path for the rounded rectangle
    CGRect roundedRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, floorf(self.bounds.size.height * 0.8));
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:6.0];
    
    // Create the arrow path
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    CGFloat midX = CGRectGetMidX(self.bounds);
    CGPoint p0 = CGPointMake(midX, CGRectGetMaxY(self.bounds));
    [arrowPath moveToPoint:p0];
    [arrowPath addLineToPoint:CGPointMake((midX - 10.0), CGRectGetMaxY(roundedRect))];
    [arrowPath addLineToPoint:CGPointMake((midX + 10.0), CGRectGetMaxY(roundedRect))];
    [arrowPath closePath];
    
    // Attach the arrow path to the rounded rect
    [roundedRectPath appendPath:arrowPath];
    
    [roundedRectPath fill];
    
    // Draw the text
    if (self.text) {
        [[UIColor colorWithWhite:1 alpha:0.8] set];
        CGSize s = [_text sizeWithFont:self.font];
        CGFloat yOffset = (roundedRect.size.height - s.height) / 2;
        CGRect textRect = CGRectMake(roundedRect.origin.x, yOffset, roundedRect.size.width, s.height);
        
        [_text drawInRect:textRect
                 withFont:self.font
            lineBreakMode:NSLineBreakByWordWrapping
                alignment:NSTextAlignmentCenter];
    }
}

- (void)setValue:(float)aValue {
    _value = aValue;
    self.text = [NSString stringWithFormat:@"%d%@", (int)round(_value), self.unit];
    [self setNeedsDisplay];
}

@end
