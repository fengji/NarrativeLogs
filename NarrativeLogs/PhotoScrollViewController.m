//
//  PhotoScrollViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/17/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "PhotoScrollViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface PhotoScrollViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PhotoScrollViewController
@synthesize photo = _photo;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;


- (void) setUpScrollViewProperties{
    // reset zoomScale back to 1 first before changing the content size.
    self.scrollView.zoomScale=1.0;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    
    self.scrollView.zoomScale = self.scrollView.bounds.size.width/self.imageView.image.size.width;
    float temp = self.scrollView.bounds.size.height/self.imageView.image.size.height;
    if(self.scrollView.zoomScale<temp){
        self.scrollView.zoomScale = temp;
    }
}

- (void) updateImageForImageURL: (NSURL *)imageURL{
    UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleWhiteLarge;
    
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [spinner startAnimating];
    [self.view addSubview:spinner];
    [spinner setCenter:self.scrollView.center];
    

        // asynchronously load image
        dispatch_queue_t downloadQueue = dispatch_queue_create("download_queue", NULL);
        dispatch_async(downloadQueue, ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            // in the main thread because UIKit runs on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [spinner removeFromSuperview];
                self.imageView.image = [UIImage imageWithData:imageData];
                [self setUpScrollViewProperties];
            });
        });

    
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
}

- (void)viewWillAppear:(BOOL)animated
{
    NSURL *imageURL = [NarrativeLogsDataAccessService imageURL:self.photo];
    [self updateImageForImageURL:imageURL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
