//
//  LogEntriesViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "LogEntriesViewController.h"
#import "NarrativeLogsDataAccessService.h"
#import "LogDetailViewController.h"
#import "LogEntriesTabBarController.h"

@interface LogEntriesViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) NSMutableArray* displayedLogEntries;
@end

@implementation LogEntriesViewController
@synthesize logEntries = _logEntries;
@synthesize displayedLogEntries = _displayedLogEntries;

- (void) setDisplayedLogEntries:(NSMutableArray *)displayedLogEntries{
    if(_displayedLogEntries != displayedLogEntries){
        _displayedLogEntries = displayedLogEntries;
        [self.tableView reloadData];
    }
}

- (void) setLogEntries:(NSArray *)logEntries
{
    if(_logEntries != logEntries){
        _logEntries = logEntries;
    }
}

- (void) loadLogEntries:(id)sender
{
    self.logEntries = [NarrativeLogsDataAccessService logEntries:sender];
    self.displayedLogEntries = [self.logEntries mutableCopy];
}

- (NSArray *) logEntries
{
    if(!_logEntries){
        [self loadLogEntries: nil];
    }
    return _logEntries;    
}

- (NSArray *) displayedLogEntries
{
    if(!_displayedLogEntries){
        [self loadLogEntries: nil];
    }
    return _displayedLogEntries;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all orientations
}

// implementing delegate method
-(void) dismissModalView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"LogDetailView"])
    {
        UINavigationController* nc = segue.destinationViewController;
        
        LogDetailViewController *viewController = (LogDetailViewController*)[nc topViewController];
        viewController.delegate = self;
        // TODO figure out passing a real entry id
        NSIndexPath * index = [self.tableView indexPathForSelectedRow];
        NSDictionary * entry = (NSDictionary*)[self.displayedLogEntries objectAtIndex:index.row];        
        viewController.entryId = [entry objectForKey:@"logEntryId"];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tabBarController.navigationItem.hidesBackButton = YES;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.displayedLogEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogEntries";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    id theLogEntry = [self.displayedLogEntries objectAtIndex:indexPath.row];
    NSString *title = nil, *subtitle = nil;
    if([theLogEntry isKindOfClass:[NSDictionary class]]){
        NSDictionary * entry = (NSDictionary *)theLogEntry;
        title = [entry objectForKey:@"logEntryName"];
        subtitle = [entry objectForKey:@"logEntryDesc"];
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text=subtitle;
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //TODO: modify data and refresh table view
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing");
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search button clicked");
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"Search end editing");
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"text changing");
    if([searchText length]==0){
        [self.displayedLogEntries removeAllObjects];
        self.displayedLogEntries = [self.logEntries mutableCopy];
        [self.tableView reloadData];
    }else{
        [self.displayedLogEntries removeAllObjects];
        for(NSDictionary* entry in self.logEntries){
            NSString *entryName = [entry objectForKey:@"logEntryName"];
            NSString *entryDesc = [entry objectForKey:@"logEntryDesc"];
            NSRange r1 = [entryName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange r2 = [entryDesc rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r1.location != NSNotFound || r2.location != NSNotFound){
                [self.displayedLogEntries addObject:entry];
            }
            [self.tableView reloadData];
        }
    }
}

@end
