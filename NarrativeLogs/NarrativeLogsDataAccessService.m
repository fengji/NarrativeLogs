//
//  NarrativeLogsDataAccessService.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "NarrativeLogsDataAccessService.h"

@implementation NarrativeLogsDataAccessService
+ (NSArray*) narrativeLogs
{
    // use webservice
    return [NSArray arrayWithObjects:@"Common", @"Mechanical", @"Unit 1", nil];
}

+ (NSArray*) shifts:(id) logName
{
    NSArray * shifts = nil;
    // use web service to load the data
    if([logName isKindOfClass:[NSString class]]){
        NSString * shift1 = [NSString stringWithFormat:@"Night-%@",(NSString*)logName];
        NSString * shift2 = [NSString stringWithFormat:@"Morning-%@",(NSString*)logName];
        NSString * shift3 = [NSString stringWithFormat:@"Afternoon-%@",(NSString*)logName];
        shifts = [NSArray arrayWithObjects:shift1, shift2, shift3,nil];
    }else{
        shifts = [NSArray arrayWithObjects:@"Night", @"Morning", @"Afternoon",nil];
    }
    return shifts;
}

@end
