//
//  CameraRollViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/28/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoUpdate.h"

@interface CameraRollViewController : UICollectionViewController 
@property (nonatomic, strong) NSMutableArray* photos;
@property (nonatomic, retain) id<PhotoUpdate> delegate;
@end
