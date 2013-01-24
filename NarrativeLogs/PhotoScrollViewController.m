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
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic) NSInteger imageIndex;
@end

@implementation PhotoScrollViewController
@synthesize photo = _photo;
@synthesize photos = _photos;
@synthesize slideshow = _slideshow;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;
@synthesize timer = _timer;

- (void) setUpScrollViewProperties{
    // reset zoomScale back to 1 first before changing the content size.
    self.scrollView.zoomScale=1.0;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    
    self.scrollView.zoomScale = self.scrollView.bounds.size.width/self.imageView.image.size.width;
    NSLog(@"zome scale: %f", self.scrollView.zoomScale);
    float temp = self.scrollView.bounds.size.height/self.imageView.image.size.height;
    if(self.scrollView.zoomScale<temp){
        self.scrollView.zoomScale = temp;
    }
}

- (void) updateImageForImageURL: (NSURL *)imageURL{
    UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
    
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [spinner startAnimating];
    [self.view addSubview:spinner];
    [spinner setCenter:self.view.center];    

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
    
    if(self.slideshow){
        self.imageIndex = 0;
        [self updateImageForPhoto:[self.photos objectAtIndex:self.imageIndex]];
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                      target: self
                                                    selector: @selector(handleTimer:)
                                                    userInfo: nil
                                                     repeats: YES];
    }else{
        [self updateImageForPhoto:self.photo];
    }
  
}

- (void) handleTimer: (NSTimer *) timer {
    self.imageIndex++;
    if ( self.imageIndex >= [self.photos count] )
        self.imageIndex = 0;
    
    NSDictionary * currentPhoto = [self.photos objectAtIndex:self.imageIndex];
    [self updateImageForPhoto:currentPhoto];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}
- (void) updateImageForPhoto:(NSDictionary *) thePhoto{
    if([thePhoto objectForKey:@"regularImage"]){
        self.imageView.image = [thePhoto objectForKey:@"regularImage"];
        [self setUpScrollViewProperties];
    }else{
        NSURL *imageURL = [NarrativeLogsDataAccessService imageURL:thePhoto];
        [self updateImageForImageURL:imageURL];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
