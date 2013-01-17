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
    UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleWhiteLarge;
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [spinner startAnimating];
    [self.collectionView addSubview:spinner];
    [spinner setCenter:self.collectionView.center];
    
    // load images async
    dispatch_queue_t thumbnailQueue = dispatch_queue_create("download thumbnail", NULL);
    dispatch_async(thumbnailQueue, ^{
        self.thumbnailImages = [NarrativeLogsDataAccessService thumbnailPhotoImages:self.photos];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView performBatchUpdates:^{
                [self.collectionView reloadData];                
                [spinner removeFromSuperview];
            } completion:nil];
        });
    });
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 200;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"thumbImageCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *thumbnailImageView = (UIImageView *)[cell viewWithTag:100];
    //NSDictionary* photo = [self.photos objectAtIndex:indexPath.row];
    
    thumbnailImageView.image = [self.thumbnailImages objectAtIndex:[indexPath row]];
    
    return cell;
}

@end
