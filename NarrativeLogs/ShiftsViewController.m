//
//  ShiftsViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/8/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "ShiftsViewController.h"
#import "NarrativeLogsDataAccessService.h"
#import "NarrativeLogsViewController.h"

@interface ShiftsViewController ()

@end

@implementation ShiftsViewController
@synthesize shifts = _shifts;

- (void) setShifts:(NSArray *)shifts
{
    if(_shifts != shifts){
        _shifts = shifts;
        [self.tableView reloadData];
    }
}

- (void) loadShifts:(id)sender
{
    self.shifts = [NarrativeLogsDataAccessService shifts:sender];
}

- (NSArray *) shifts
{
    if(!_shifts){
        [self loadShifts: nil];
    }
    return _shifts;
    
}

- (NarrativeLogsViewController *)narrativeLogsViewController
{
    // getting the master view controller
    id nlvc =[[self.splitViewController.viewControllers objectAtIndex:0] topViewController];
    return nlvc;
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
    return [self.shifts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Shifts Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    id theShift = [self.shifts objectAtIndex:indexPath.row];
    NSString *title = nil;
    if([theShift isKindOfClass:[NSString class]]){
        title = theShift;
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"Active";
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
    
    [[self narrativeLogsViewController] performSegueWithIdentifier:@"ShiftLogView" sender:[self narrativeLogsViewController]];
}

@end
