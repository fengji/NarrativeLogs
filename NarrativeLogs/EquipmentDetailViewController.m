//
//  EquipmentDetailViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/17/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "EquipmentDetailViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface EquipmentDetailViewController ()

@end

@implementation EquipmentDetailViewController
@synthesize equipmentDetail = _equipmentDetail;
@synthesize equipmentId = _equipmentId;

- (void) setEquipmentDetail:(NSDictionary *)equipmentDetail
{
    if(_equipmentDetail != equipmentDetail){
        _equipmentDetail = equipmentDetail;
        [self.tableView reloadData];
    }
}

- (void) loadEquipmentDetail:(id)sender
{
    self.equipmentDetail = [NarrativeLogsDataAccessService equipmentDetail:sender];
}

- (NSDictionary *) equipmentDetail
{
    if(!_equipmentDetail){
        [self loadEquipmentDetail: self.equipmentId];
    }
    return _equipmentDetail;
    
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
    return [[self.equipmentDetail objectForKey:@"label"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* labelArray = [self.equipmentDetail objectForKey:@"label"];
    return [[labelArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EquipmentDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSArray* labels = [self.equipmentDetail objectForKey:@"label"];
    NSArray* values = [self.equipmentDetail objectForKey:@"value"];
    
    NSArray* currentLabels = [labels objectAtIndex:indexPath.section];
    NSArray* currentValues = [values objectAtIndex:indexPath.section];
    NSString* title = [currentLabels objectAtIndex:indexPath.row];
    NSString*subtitle = [currentValues objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    
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
