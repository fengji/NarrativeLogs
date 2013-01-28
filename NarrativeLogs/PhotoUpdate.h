//
//  PhotoUpdate.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/28/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PhotoUpdate <NSObject>
- (void) updatePhotosWith: (NSArray*) photos;
@end
