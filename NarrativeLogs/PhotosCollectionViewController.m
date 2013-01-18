//
//  PhotosCollectionViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/16/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "NarrativeLogsDataAccessService.h"
#import "PhotoScrollViewController.h"

@interface PhotosCollectionViewController ()
@property (nonatomic, strong) NSArray * thumbnailImages;
@property (nonatomic, strong) NSMutableArray * selectedPhotos;
@property (nonatomic) BOOL editMode;
@property (nonatomic, strong) UIBarButtonItem* addButton;
@property (nonatomic, strong) UIBarButtonItem* deleteButton;
@property (nonatomic, strong) UIBarButtonItem* emailButton;
@end

@implementation PhotosCollectionViewController
@synthesize photos = _photos;
@synthesize thumbnailImages = _thumbnailImages;
@synthesize selectedPhotos = _selectedPhotos;
@synthesize editMode = _editMode;
@synthesize addButton = _addButton;
@synthesize deleteButton = _deleteButton;
@synthesize emailButton = _emailButton;

- (NSArray*)photos
{
    if(!_photos){
        _photos = [NarrativeLogsDataAccessService photos:nil];
    }
    return _photos;
}

- (NSMutableArray*) selectedPhotos{
    if(!_selectedPhotos){
        _selectedPhotos = [@[] mutableCopy];
    }
    return _selectedPhotos;
}

- (UIBarButtonItem*) addButton{
    if(!_addButton){
        _addButton = [[UIBarButtonItem alloc] init];
        [_addButton setTitle:@"Add"];
        _addButton.target = self;
        _addButton.action = @selector(addAction:);
    }
    return _addButton;
    
}

- (UIBarButtonItem*) deleteButton{
    if(!_deleteButton){
        _deleteButton = [[UIBarButtonItem alloc]init];
        [_deleteButton setTitle:@"Delete"];
        _deleteButton.target = self;
        _deleteButton.action=@selector(deleteAction:);
    }

    return _deleteButton;
}

- (UIBarButtonItem*) emailButton{
    if(!_emailButton){
        _emailButton = [[UIBarButtonItem alloc]init];
        [_emailButton setTitle:@"Share"];
        _emailButton.target = self;
        _emailButton.action=@selector(emailAction:);
    }
    
    return _emailButton;
}

- (void) disableEnableButtons{
    if([self.selectedPhotos count] >0){
        [self.deleteButton setEnabled:YES];
        [self.emailButton setEnabled:YES];
    }else{
        [self.emailButton setEnabled:NO];
        [self.deleteButton setEnabled:NO];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ImageView"]){
        NSInteger index = 0;
        NSArray* indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath * ip = (NSIndexPath *)[indexPaths objectAtIndex:0];
        index = ip.row;
        
        NSDictionary *selectedPhoto = [self.photos objectAtIndex:index];
        PhotoScrollViewController* psvc = [segue destinationViewController];
        psvc.photo = selectedPhoto;
    }
}

- (IBAction)editPhotos:(id)sender {
    UIBarButtonItem * editButton = (UIBarButtonItem*)sender;
    if(!self.editMode){
        self.editMode = YES;
        [editButton setTitle:@"Cancel"];
        [self.collectionView setAllowsMultipleSelection:YES];
        
    }else{
        self.editMode = NO;
        [editButton setTitle:@"Edit"];
        [self.collectionView setAllowsMultipleSelection:NO];
        
        for(NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems)
        {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        
        [self.selectedPhotos removeAllObjects];
    }
    
    [self updateNavBarItems];
}

- (IBAction) addAction:(id)sender {
    NSLog(@"Add button clicked");
}

- (IBAction) deleteAction:(id)sender{
    NSLog(@"Delete button clicked");
}

- (IBAction) emailAction: (id)sender{
    NSLog(@"Share button clicked");
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
    
    [self updateNavBarItems];
    [self disableEnableButtons];
}

- (void) updateNavBarItems
{
    NSArray* existingRightNavItems = [self.navigationItem rightBarButtonItems];
    NSMutableArray* rightNavItems = [existingRightNavItems mutableCopy];
    if(self.editMode){
        [rightNavItems insertObject:self.deleteButton atIndex:0];
        [rightNavItems insertObject:self.emailButton atIndex:0];
        [rightNavItems insertObject:self.addButton atIndex:0];
    }else{
        if([rightNavItems count] == 4){
            [rightNavItems removeObjectAtIndex:0];
            [rightNavItems removeObjectAtIndex:0];
            [rightNavItems removeObjectAtIndex:0];
        }
    }
    
    [self.navigationItem setRightBarButtonItems:rightNavItems animated:YES];
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
    // hard coded for now
    return 20;
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

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* photo = [self.photos objectAtIndex:indexPath.row];
    
    if(self.editMode){
        [self.selectedPhotos addObject:photo];
        [self disableEnableButtons];
    }else{
        [self performSegueWithIdentifier:@"ImageView" sender:photo];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.editMode){
        NSDictionary* photo = [self.photos objectAtIndex:indexPath.row];
        [self.selectedPhotos removeObject:photo];
        [self disableEnableButtons];
    }
}

@end
