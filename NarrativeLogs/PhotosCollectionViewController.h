//
//  PhotosCollectionViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/16/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PhotoUpdate.h"
@interface PhotosCollectionViewController : UICollectionViewController <PhotoUpdate>
@property (nonatomic, strong) NSMutableArray* photos;
@end
