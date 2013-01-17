//
//  PhotosCollectionViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/16/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface PhotosCollectionViewController ()
@property (nonatomic, strong) NSArray * thumbnailImages;
@end

@implementation PhotosCollectionViewController
@synthesize photos = _photos;
@synthesize thumbnailImages = _thumbnailImages;

- (void) setPhotos:(NSArray *)photos{
    if(_photos != photos){
        _photos = photos;
    }
}

- (NSArray*)photos
{
    if(!_photos){
        _photos = [NarrativeLogsDataAccessService photos:nil];
    }
    return _photos;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.thumbnailImages = [NarrativeLogsDataAccessService thumbnailPhotoImages:self.photos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"thumbImageCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *thumbnailImageView = (UIImageView *)[cell viewWithTag:100];
    thumbnailImageView.image = [self.thumbnailImages objectAtIndex:indexPath.row];
    
    return cell;
}

@end
