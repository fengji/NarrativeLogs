//
//  NarrativeLogsDataAccessService.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "NarrativeLogsDataAccessService.h"
#import "FlickrFetcher.h"

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
    // TO be replaced bt web service call
    NSMutableArray* logEntries = [[NSMutableArray alloc] init];
    for(int i=0; i<20; i++){
        NSMutableDictionary *entry = [[NSMutableDictionary alloc] init];
        [entry setValue:[NSString stringWithFormat:@"%d", i] forKey:@"logEntryId"];
        [entry setValue:[NSString stringWithFormat:@"Unit %d", i] forKey:@"logEntryName"];
        [entry setValue:[NSString stringWithFormat:@"Log entry %d description", i] forKey:@"logEntryDesc"];
        [logEntries addObject:entry];
    }
    return [logEntries copy];
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
    NSArray* entryLabels = [NSArray arrayWithObjects:@"Standard Entry Template",
                            @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                            @"Position",
                            @"Unit",
                            @"Service Status",
                            @"Standing Order",
                            @"Open Item",
                            @"Maintenance Rule",
                            @"Equipment",
                            @"Reference Docs",
                            @"Photos",
                            @"Share Log Entry With ...",
                            @"Copy Log Entry To ...",
                            nil];
    NSArray* values = [NSArray arrayWithObjects:@"0-SI-EBT-250-100.1 125 VDC Start",
                       @"",
                       @"Shift Manager",
                       @"",
                       @"",
                       @"YES",
                       @"NO",
                       @"NO",
                       @"2",
                       @"2",
                       @"2",
                       @"3",
                       @"1",
                       nil];
    [entry setObject:entryLabels forKey:@"entryLabels"];
    [entry setObject:values forKey:@"values"];
    return entry;
}

+ (NSArray*) logEquipmentList:(id)entryId
{
    return [NSArray arrayWithObjects:@"Equipment 1", @"Equipment 2", nil];
}

+ (NSDictionary*) equipmentDetail:(id)equipmentId
{
    NSArray* labelArray1 = [NSArray arrayWithObjects:@"Equipment ID", nil];
    NSArray* labelArray2 = [NSArray arrayWithObjects:@"Description", @"Location", @"Unit",nil];
    NSArray* labelArray3 = [NSArray arrayWithObjects:@"System",@"Type",@"Building", nil];
    NSArray* label = [NSArray arrayWithObjects:labelArray1, labelArray2, labelArray3,nil];
    NSArray* detailValueArray1 = [NSArray arrayWithObjects:@"0-BAT-024-QVC", nil];
    NSArray* detailValueArray2 = [NSArray arrayWithObjects:@"124 DC VITAL BATTERY III", @"Battery Room", @"U-Common",nil];
    NSArray* detailValueArray3 = [NSArray arrayWithObjects:@"", @"P-Power", @"",nil];
    NSArray* detailValue = [NSArray arrayWithObjects:detailValueArray1,detailValueArray2,detailValueArray3, nil];
    NSMutableDictionary *detail = [[NSMutableDictionary alloc]init];
    [detail setObject:label forKey:@"label"];
    [detail setObject:detailValue forKey:@"value"];
    return detail;
}

+ (NSDictionary*) addEquipmentDetail
{
    NSArray* labelArray1 = [NSArray arrayWithObjects:@"Equipment ID", nil];
    NSArray* labelArray2 = [NSArray arrayWithObjects:@"Configuration", @"Service Status",nil];
    NSArray* detailValueArray1 = [NSArray arrayWithObjects:@"Selected Equipment", nil];
    NSArray* detailValueArray2 = [NSArray arrayWithObjects:@"Selected Configuration", @"Selected Service Status",nil];
    NSArray* label = [NSArray arrayWithObjects:labelArray1, labelArray2,nil];
    NSArray* detailValue = [NSArray arrayWithObjects:detailValueArray1,detailValueArray2, nil];
    NSMutableDictionary *detail = [[NSMutableDictionary alloc]init];
    [detail setObject:label forKey:@"label"];
    [detail setObject:detailValue forKey:@"value"];
    return detail;
}

+ (NSArray*) existingEquipment{
    NSMutableArray * equipArray = [[NSMutableArray alloc]init];
    // Alphabetic array
    NSMutableArray *alphabetArray;
    alphabetArray = [[NSMutableArray alloc] init];
    for(char c = 'A'; c <= 'Z'; c++)
    {
        [alphabetArray addObject:[NSString stringWithFormat:@"%c", c]];
    }
    
    for(NSString * prefix in alphabetArray){
        NSMutableDictionary *equip = [[NSMutableDictionary alloc] init];
        [equip setObject:[NSString stringWithFormat:@"%@ item 1",  prefix] forKey:@"title"];
        [equipArray addObject:equip];
        equip = [[NSMutableDictionary alloc] init];
        [equip setObject:[NSString stringWithFormat:@"%@ item 2",  prefix] forKey:@"title"];
        [equipArray addObject:equip];        
        equip = [[NSMutableDictionary alloc] init];
        [equip setObject:[NSString stringWithFormat:@"%@ item 3",  prefix] forKey:@"title"];
        [equipArray addObject:equip];
    }
    return equipArray;
}

+ (NSArray*) photos:(id)entryId
{
    NSArray * photos = nil;
    // for now load flickr photos
    NSArray *topPlaces = [FlickrFetcher topPlaces];
    // sort the array. This array is an array of NSDictionary, sorting key is @"_content"
    NSSortDescriptor * contentDescriptor = [[NSSortDescriptor alloc] initWithKey:@"_content" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray * descriptors = [NSArray arrayWithObjects:contentDescriptor, nil];
    NSArray * sortedTopPlaces =[topPlaces sortedArrayUsingDescriptors:descriptors];
    
    if([sortedTopPlaces count] >0){
        NSDictionary * place = [sortedTopPlaces objectAtIndex: [sortedTopPlaces count]/2];
        photos = [FlickrFetcher photosInPlace:place maxResults:20];
    }
    return photos;
}

+ (NSArray*) thumbnailPhotoImages:(NSArray*)photos
{
    NSMutableArray* thumbnailPhotoImages = [[NSMutableArray alloc]initWithCapacity:[photos count]];
    for(id p in photos){
        NSDictionary *photo = (NSDictionary*)p;
        NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatSquare];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage * image =[UIImage imageWithData:data];
        [thumbnailPhotoImages addObject:image];
    }
    return thumbnailPhotoImages;
}

+ (UIImage*) thumbnailPhotoImage: (NSDictionary *)photo{
    NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatSquare];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage * image =[UIImage imageWithData:data];
    return image;
}

+ (UIImage*) photoImage: (NSDictionary *)photo
{
    NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage * image =[UIImage imageWithData:data];
    return image;
}

+ (NSURL*) imageURL:(NSDictionary *)photo{
    NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
    return url;
}


@end
