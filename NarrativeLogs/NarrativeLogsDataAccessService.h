//
//  NarrativeLogsDataAccessService.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NarrativeLogsDataAccessService : NSObject
+ (NSArray*) narrativeLogs;
+ (NSArray*) shifts:(id) logName;
@end
