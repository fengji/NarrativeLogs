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
#import <MessageUI/MessageUI.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotosCollectionViewController () <MFMailComposeViewControllerDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) NSMutableArray * thumbnailImages;
@property (nonatomic, strong) NSMutableArray * selectedPhotos;
@property (nonatomic, strong) NSMutableArray * selectedPhotoIndices;
@property (nonatomic) BOOL editMode;
@property (nonatomic, strong) UIBarButtonItem* addButton;
@property (nonatomic, strong) UIBarButtonItem* deleteButton;
@property (nonatomic, strong) UIBarButtonItem* emailButton;
@property (nonatomic, strong) UIBarButtonItem* cameraButton;
@property (nonatomic) BOOL newMedia;
@property (nonatomic, strong) UIPopoverController *poController;
@end

@implementation PhotosCollectionViewController
@synthesize photos = _photos;
@synthesize thumbnailImages = _thumbnailImages;
@synthesize selectedPhotos = _selectedPhotos;
@synthesize selectedPhotoIndices = _selectedPhotoIndices;
@synthesize editMode = _editMode;
@synthesize addButton = _addButton;
@synthesize deleteButton = _deleteButton;
@synthesize emailButton = _emailButton;
@synthesize cameraButton = _cameraButton;
@synthesize newMedia = _newMedia;
@synthesize poController = _poController;

- (NSArray*)photos
{
    if(!_photos){
        _photos = [[NarrativeLogsDataAccessService photos:nil] mutableCopy];
    }
    return _photos;
}

- (NSMutableArray*) selectedPhotos{
    if(!_selectedPhotos){
        _selectedPhotos = [@[] mutableCopy];
    }
    return _selectedPhotos;
}

-(NSMutableArray*) selectedPhotoIndices{
    if(!_selectedPhotoIndices){
        _selectedPhotoIndices = [@[] mutableCopy];
    }
    return _selectedPhotoIndices;
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

- (UIBarButtonItem*) cameraButton{
    if(!_cameraButton){
        _cameraButton = [[UIBarButtonItem alloc] init];
        [_cameraButton setTitle:@"Camera"];
        _cameraButton.target = self;
        _cameraButton.action = @selector(cameraAction:);
    }
    return _cameraButton;
    
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
        NSLog(@"%@", selectedPhoto);
        
        PhotoScrollViewController* psvc = [segue destinationViewController];
        psvc.photo = selectedPhoto;
    }
}

- (IBAction)editPhotos:(id)sender {
    [self dismissPopover];
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
        [self.selectedPhotoIndices removeAllObjects];
    }
    
    [self updateNavBarItems];
    [self disableEnableButtons];
}

- (void) dismissPopover{
    if(self.poController){
        [self.poController dismissPopoverAnimated:YES];
    }
}

- (IBAction) addAction:(id)sender {
    NSLog(@"Add button clicked");
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        self.newMedia = NO;
        
        [self dismissPopover];
        self.poController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.poController.delegate=self;
        [self.poController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
    }
    
}

- (void) cameraAction:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        self.newMedia = YES;
        
        [self dismissPopover];
        self.poController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.poController.delegate=self;
        [self.poController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Image picked %@", info);
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self.poController dismissPopoverAnimated:YES];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSURL *url = info[UIImagePickerControllerReferenceURL];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

        if (self.newMedia){
            /**
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
             */
            [library writeImageToSavedPhotosAlbum:[image CGImage] metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @"Save failed"
                                          message: @"Failed to save image"
                                          delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    [alert show];
                }else{
                    // add image from camera roll to photo list
                    [self addPhotoFromCameraRoll:library withURL:assetURL];
                    
                }
            }];
        }else{
            // add to photo list
            [self addPhotoFromCameraRoll:library withURL:url];
            
        }
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

- (void) addPhotoFromCameraRoll: (ALAssetsLibrary*)library withURL:(NSURL*) url{
    [library assetForURL:url resultBlock:^(ALAsset *asset) {
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
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        
    }];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }else{
        // add image from camera roll to photo list


    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}


- (IBAction) deleteAction:(id)sender{
    NSLog(@"Delete button clicked");
    [self dismissPopover];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"The selected photos will be removed from the log." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}
// delegate methods for UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // when OK clicked
    if(buttonIndex == alertView.firstOtherButtonIndex){
        [self.collectionView performBatchUpdates:^{
            //update datamodel
            [self.photos removeObjectsInArray:self.selectedPhotos];
            //delete cell
            [self.collectionView deleteItemsAtIndexPaths:self.selectedPhotoIndices];
            //remove selection
            [self.selectedPhotos removeAllObjects];
            [self.selectedPhotoIndices removeAllObjects];
        } completion:nil];
        [self disableEnableButtons];
    }
}

- (void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // when Cancel clicked
    if(buttonIndex == alertView.cancelButtonIndex){
        [self.selectedPhotos removeAllObjects];
        [self.selectedPhotoIndices removeAllObjects];
        [self.collectionView reloadData];
        [self disableEnableButtons];
    }
}

- (IBAction) emailAction: (id)sender{
    NSLog(@"Share button clicked");
    [self dismissPopover];
    [self showMailComposerAndSend];
}

// email photo
- (void) showMailComposerAndSend{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Photos"];
        
        NSMutableString *emailBody = [NSMutableString string];
        for(NSDictionary *photo in self.selectedPhotos)
        {
            NSURL* url = [NarrativeLogsDataAccessService imageURL:photo];
            [emailBody appendFormat:@"<div><img src='%@'></div><br>",[url absoluteString]];
        }
        
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [self presentViewController:mailer animated:YES completion:^{}];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failure"
                                                        message:@"Your device doesn't support in-app email"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

// delegate method for MFMailComposeViewControllerDelegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:^{}];
}
//

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
        self.thumbnailImages = [[NarrativeLogsDataAccessService thumbnailPhotoImages:self.photos] mutableCopy];
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
        [rightNavItems insertObject:self.cameraButton atIndex:0];
    }else{
        if([rightNavItems count] == 5){
            [rightNavItems removeObjectAtIndex:0];
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
    return [self.photos count];
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
        [self.selectedPhotoIndices addObject:indexPath];
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
        [self.selectedPhotoIndices removeObject:indexPath];
        [self disableEnableButtons];
    }
}



@end
