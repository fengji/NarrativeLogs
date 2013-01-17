//
//  PhotoScrollViewController.h
//  NarrativeLogs
//
//  Created by Feng Ji on 1/17/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollViewController : UIViewController
@property (nonatomic, strong) NSDictionary *photo;
- (void) updateImageForImageURL: (NSURL *)imageURL;
@end
