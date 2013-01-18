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
+ (NSArray*) logEntries:(id) shift;
+ (NSArray*) shiftLogItems:(id)shift :(id)logType;
+ (NSDictionary*) logEntryDetail: (id)entryId;
+ (NSArray*) logEquipmentList:(id)entryId;
+ (NSDictionary*) equipmentDetail:(id)equipmentId;
+ (NSDictionary*) addEquipmentDetail;
+ (NSArray*) photos:(id)entryId;
+ (NSArray*) thumbnailPhotoImages:(NSArray*)photos;
+ (UIImage*) thumbnailPhotoImage: (NSDictionary *)photo;
+ (UIImage*) photoImage: (NSDictionary *)photo;
+ (NSURL*) imageURL:(NSDictionary *)photo;

@end
