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
