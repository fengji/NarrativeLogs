//
//  NarrativeLogsViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/8/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "NarrativeLogsViewController.h"
#import "ShiftsViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface NarrativeLogsViewController ()

@end

@implementation NarrativeLogsViewController
@synthesize logs = _logs;

- (void) setLogs:(NSArray *)logs
{
    if(_logs != logs){
        _logs = logs;
        [self.tableView reloadData];
    }
}

- (void) loadLogs:(id)sender
{
    // use web service to load the data
    _logs = [NarrativeLogsDataAccessService narrativeLogs];
    
}

- (NSArray *) logs
{
    if(!_logs){
        [self loadLogs:nil];
    }
    return _logs;

}

- (ShiftsViewController* ) shiftsViewController
{
    ShiftsViewController* shvc = [self.splitViewController.viewControllers lastObject];
    if(![shvc isKindOfClass:[ShiftsViewController class]]){
        shvc = nil;
    }
    return shvc;
}

- (void) handleSelectLog:(NSString *)log
{
    ShiftsViewController* shvc = [self shiftsViewController];
    [shvc loadShifts:log];
}

// pull down to refresh
// Details see: 
// http://www.intertech.com/Blog/Post/iOS-6-Pull-to-Refresh-%28UIRefreshControl%29.aspx
//
-(void)refreshView:(UIRefreshControl *)refresh {
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
    // custom refresh logic would be placed here...    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MMM d, h:mm a"];
    
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                                    
                            [formatter stringFromDate:[NSDate date]]];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    [refresh endRefreshing];
    
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
    
    // pull down to refresh
    // Details see:
    // http://www.intertech.com/Blog/Post/iOS-6-Pull-to-Refresh-%28UIRefreshControl%29.aspx
    //
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self
             action:@selector(refreshView:)
             forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // select the first row of the table
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self  handleSelectLog:cell.textLabel.text];
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
    return [self.logs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Narrative Logs Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    id nLog = [self.logs objectAtIndex:indexPath.row];
    NSString *title = nil;
    if([nLog isKindOfClass:[NSString class]]){
        title = nLog;
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
    NSString * nLog = [self.logs objectAtIndex:indexPath.row];
    [self handleSelectLog:nLog];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
