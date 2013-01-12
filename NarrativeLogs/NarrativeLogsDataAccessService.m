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

+ (NSArray*) logEntries:(id) shift{
    NSArray * logEntries = nil;
    // use webservice to load data
    NSMutableDictionary *entry1 = [[NSMutableDictionary alloc] init];
    [entry1 setValue:@"1" forKey:@"logEntryId"];
    [entry1 setValue:@"Unit 1" forKey:@"logEntryName"];
    [entry1 setValue:@"log entry 1 descriptions" forKey:@"logEntryDesc"];
    NSMutableDictionary *entry2 = [[NSMutableDictionary alloc] init];
    [entry2 setValue:@"2" forKey:@"logEntryId"];
    [entry2 setValue:@"Unit 2" forKey:@"logEntryName"];
    [entry2 setValue:@"log entry 2 descriptions" forKey:@"logEntryDesc"];
    NSMutableDictionary *entry3 = [[NSMutableDictionary alloc] init];
    [entry3 setValue:@"3" forKey:@"logEntryId"];
    [entry3 setValue:@"Unit 3" forKey:@"logEntryName"];
    [entry3 setValue:@"log entry 3 descriptions" forKey:@"logEntryDesc"];
    logEntries = [[NSArray alloc] initWithObjects:entry1, entry2, entry3, nil];
    return logEntries;
}

+ (NSArray*) shiftLogItems:(id)shift :(id)logType
{
    NSArray * shiftLogItems = [NSArray arrayWithObjects:@"Log Entries", @"Plant Parameters", @"Shift Roaster", @"Upload", nil];
    return shiftLogItems;
                            
}

+ (NSDictionary*) logEntryDetail: (id)entryId
{
    NSMutableDictionary *entry = [[NSMutableDictionary alloc] init];
    [entry setValue:@"1" forKey:@"logEntryId"];
    [entry setValue:@"Unit 1" forKey:@"logEntryName"];
    [entry setValue:@"log entry 1 descriptions" forKey:@"logEntryDesc"];
    return entry;
}


@end
