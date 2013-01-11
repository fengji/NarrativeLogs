//
//  LogEntriesViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/9/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "LogEntriesViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface LogEntriesViewController ()

@end

@implementation LogEntriesViewController
@synthesize logEntries = _logEntries;

- (void) setLogEntries:(NSArray *)logEntries
{
    if(_logEntries != logEntries){
        _logEntries = logEntries;
        [self.tableView reloadData];
    }
}

- (void) loadLogEntries:(id)sender
{
    self.logEntries = [NarrativeLogsDataAccessService logEntries:sender];
}

- (NSArray *) logEntries
{
    if(!_logEntries){
        [self loadLogEntries: nil];
    }
    return _logEntries;
    
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
    return [self.logEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogEntries";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    id theLogEntry = [self.logEntries objectAtIndex:indexPath.row];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
