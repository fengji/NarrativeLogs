//
//  CameraRollViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/28/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "CameraRollViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotosCollectionViewController.h"

@interface CameraRollViewController ()
@property (nonatomic, strong) NSMutableArray * thumbnailImages;
@property (nonatomic, strong) NSMutableArray * selectedPhotos;
@property (nonatomic, strong) UIBarButtonItem *selectedButton;
@property (nonatomic, strong) UIBarButtonItem *allButton;

@end

@implementation CameraRollViewController

@synthesize photos = _photos;
@synthesize thumbnailImages = _thumbnailImages;
@synthesize selectedPhotos = _selectedPhotos;
@synthesize selectedButton = _selectedButton;
@synthesize allButton = _allButton;
@synthesize delegate = _delegate;

- (NSArray*)photos
{
    if(!_photos){
        _photos = [@[] mutableCopy];
    }
    return _photos;
}

- (NSArray*)thumbnailImages
{
    if(!_thumbnailImages){
        _thumbnailImages = [@[] mutableCopy];
    }
    return _thumbnailImages;
}

- (NSMutableArray*) selectedPhotos{
    if(!_selectedPhotos){
        _selectedPhotos = [@[] mutableCopy];
    }
    return _selectedPhotos;
}

- (UIBarButtonItem*) allButton{
    if(!_allButton){
        _allButton = [[UIBarButtonItem alloc] init];
        [_allButton setTitle:@"Add All"];
        _allButton.target = self;
        _allButton.action = @selector(addAllAction:);
    }
    return _allButton;
    
}


- (UIBarButtonItem*) selectedButton{
    if(!_selectedButton){
        _selectedButton = [[UIBarButtonItem alloc] init];
        [_selectedButton setTitle:@"Add Selected"];
        _selectedButton.target = self;
        _selectedButton.action = @selector(addSelectedAction:);
    }
    return _selectedButton;
    
}

- (IBAction) addAllAction:(id)sender {
    [self.delegate updatePhotosWith:self.photos];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction) addSelectedAction:(id)sender {
    [self.delegate updatePhotosWith:self.selectedPhotos];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) updateNavBarItems
{
    NSMutableArray* rightNavItems = [@[] mutableCopy];
    [rightNavItems insertObject:self.allButton atIndex:0];
    [rightNavItems insertObject:self.selectedButton atIndex:0];
    [self.navigationItem setRightBarButtonItems:rightNavItems animated:YES];
}

- (void) disableEnableButtons{
    if([self.selectedPhotos count] >0){
        [self.selectedButton setEnabled:YES];
    }else{
        [self.selectedButton setEnabled:NO];
    }
}

- (void) loadCameraRollPhotosWithSpinner: (UIActivityIndicatorView*) spinner
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        // iterate asset group
        [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
            // emumerate assets
            UIImage * thumbNailImage = [UIImage imageWithCGImage: [asset thumbnail]];
            //UIImage * regularImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] ];
            ALAssetRepresentation* representation = [asset defaultRepresentation];
            
            // Retrieve the image orientation from the ALAsset
            UIImageOrientation orientation = UIImageOrientationUp;
            NSNumber* orientationValue = [asset valueForProperty:@"ALAssetPropertyOrientation"];
            if (orientationValue != nil) {
                orientation = [orientationValue intValue];
            }
            
            CGFloat scale  = 1;
            UIImage* regularImage = [UIImage imageWithCGImage:[representation fullResolutionImage]
                                                        scale:scale orientation:orientation];
            
            NSMutableDictionary * newPhoto = [[NSMutableDictionary alloc] init];
            [newPhoto setObject:thumbNailImage forKey:@"thumbnailImage"];
            [newPhoto setObject:regularImage forKey:@"regularImage"];
            [self.photos addObject:newPhoto];
            [self.thumbnailImages addObject:thumbNailImage];            
        }];
        // update view
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [spinner removeFromSuperview];
        });
    } failureBlock:^(NSError *error) {
        NSLog(@"Error in loading camera rolls %@", error);
    }];
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
    [self.collectionView setAllowsMultipleSelection:YES];
    [self updateNavBarItems];
    
    // Do any additional setup after loading the view.
    UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleWhiteLarge;
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [spinner startAnimating];
    [self.collectionView addSubview:spinner];
    [spinner setCenter:self.collectionView.center];
    
    dispatch_queue_t thumbnailQueue = dispatch_queue_create("load images", NULL);
    dispatch_async(thumbnailQueue, ^{
        [self loadCameraRollPhotosWithSpinner:spinner];
    });
    [self disableEnableButtons];
    NSLog(@"CameraRollViewController's viewDidLoad called");
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    static NSString *identifier = @"CameraRollCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *thumbnailImageView = (UIImageView *)[cell viewWithTag:100];
    
    thumbnailImageView.image = [self.thumbnailImages objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* photo = [self.photos objectAtIndex:indexPath.row];
    [self.selectedPhotos addObject:photo];
    [self disableEnableButtons];

}

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* photo = [self.photos objectAtIndex:indexPath.row];
    [self.selectedPhotos removeObject:photo];
    [self disableEnableButtons];
}
@end
