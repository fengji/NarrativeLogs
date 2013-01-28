//
//  LogEntriesTabBarController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/26/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "LogEntriesTabBarController.h"
@interface LogEntriesTabBarController ()

@end

@implementation LogEntriesTabBarController
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    [self handleSplitViewBarButtonItem:splitViewBarButtonItem];
}

- (void)handleSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    NSMutableArray *navItems = [[self.navigationItem leftBarButtonItems] mutableCopy];
    if(!navItems){
        navItems = [@[] mutableCopy];
    }
    if (_splitViewBarButtonItem){
        [navItems removeObject:_splitViewBarButtonItem];
    }
    if (splitViewBarButtonItem){
        [navItems insertObject:splitViewBarButtonItem atIndex:0];
    }
    [self.navigationItem setLeftBarButtonItems:navItems animated:YES];
    _splitViewBarButtonItem = splitViewBarButtonItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self handleSplitViewBarButtonItem:self.splitViewBarButtonItem];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if([viewController conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter) ]){
        id destinationViewController = viewController;        
        [destinationViewController setSplitViewBarButtonItem:self.splitViewBarButtonItem];
    }
}

@end
