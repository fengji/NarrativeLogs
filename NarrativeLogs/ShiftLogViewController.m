//
//  ShiftLogViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "ShiftLogViewController.h"
#import "NarrativeLogsDataAccessService.h"
#import "ShiftsViewController.h"
#import "SplitViewBarButtonItemPresenter.h"

@interface ShiftLogViewController ()
@property (nonatomic) BOOL initialized;
@end

@implementation ShiftLogViewController
@synthesize shiftLogItems = _shiftLogItems;
@synthesize initialized = _initialized;

- (void) initialize
{
    if(!self.initialized){
        self.initialized = YES;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
        UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self handleSelectLogItem :cell.textLabel.text];
    }
}

- (void)awakeFromNib  // always try to be the split view's delegate
{
    [super awakeFromNib];
    self.splitViewController.delegate = self;
}

- (void) setShiftLogItems:(NSArray *)shiftLogItems
{
    if(_shiftLogItems != shiftLogItems){
        _shiftLogItems = shiftLogItems;
        [self.tableView reloadData];
    }
}

- (void) loadShiftLogItems:(id) sender
{
    self.shiftLogItems = [NarrativeLogsDataAccessService shiftLogItems:sender :sender];
}

- (NSArray *) shiftLogItems
{
    if(!_shiftLogItems){
        [self loadShiftLogItems: nil];
    }
    return _shiftLogItems;
    
}

- (UINavigationController*) detailViewNavigationController{
    id dvnc = [self.splitViewController.viewControllers lastObject];
    if(![dvnc isKindOfClass:[UINavigationController class]]){
        dvnc = nil;
    }
    return dvnc;
}


- (void) handleSelectLogItem:(NSString *)logItem
{
    // TODO: need to perform segue to different view based on selection
    id shiftViewController = nil; // [[self detailViewNavigationController] topViewController];
    
    NSArray *viewControllers = [[self detailViewNavigationController] viewControllers];
    NSEnumerator *e = [viewControllers objectEnumerator];
    id object;
    while (object = [e nextObject]) {
        if([object isKindOfClass:[ShiftsViewController class]]){
            shiftViewController = object;
            break;
        }
    }
    if([logItem isEqualToString:@"Log Entries"]){
        [shiftViewController performSegueWithIdentifier:@"LogEntriesView" sender:shiftViewController];
    } else if([logItem isEqualToString:@"Plant Parameters"]){
        [shiftViewController performSegueWithIdentifier:@"PlantParamView" sender:shiftViewController];
    } else if([logItem isEqualToString:@"Shift Roaster"]){
        [shiftViewController performSegueWithIdentifier:@"ShiftRosterView" sender:shiftViewController];
    } else if([logItem isEqualToString:@"Upload"]){
        [shiftViewController performSegueWithIdentifier:@"UploadView" sender:shiftViewController];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // select the first row of the table

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initialize];
}

- (void) willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    [self initialize];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shiftLogItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShiftLogItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    id shitLogItem = [self.shiftLogItems objectAtIndex:indexPath.row];
    NSString *title = nil;
    if([shitLogItem isKindOfClass:[NSString class]]){
        title = shitLogItem;
    }
    cell.textLabel.text = title;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    NSString * nShiftLogItem = [self.shiftLogItems objectAtIndex:indexPath.row];
    [self handleSelectLogItem :nShiftLogItem];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - UISplitViewControllerDelegate
- (id <SplitViewBarButtonItemPresenter>)splitViewBarButtonItemPresenter
{
    UINavigationController* detailViewNavigationController = [self detailViewNavigationController];
    
    id detailVC = [detailViewNavigationController visibleViewController];
    if([detailVC isKindOfClass: [UITabBarController class]]){
        detailVC = [((UITabBarController*)detailVC) selectedViewController];
    }
    
    if (![detailVC conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)]) {
        detailVC = nil;
    }
    return detailVC;
}

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return  UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Log";
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self splitViewBarButtonItemPresenter].splitViewBarButtonItem = nil;
}

@end
