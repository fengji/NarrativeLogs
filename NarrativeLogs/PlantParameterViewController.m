//
//  PlantParameterViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "PlantParameterViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface PlantParameterViewController () 

@end

@implementation PlantParameterViewController
@synthesize plantParameters = _plantParameters;

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.navigationItem.hidesBackButton = YES;
}

- (void) setPlantParameters:(NSMutableDictionary *)plantParameters{
    if(_plantParameters != plantParameters){
        _plantParameters = plantParameters;
    }
    [self.tableView reloadData];
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
    self.plantParameters = [[NarrativeLogsDataAccessService plantParameters] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.plantParameters objectForKey:@"label"]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* labelArray = [self.plantParameters objectForKey:@"label"];
    return [[labelArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlantParameterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSArray* labels = [self.plantParameters objectForKey:@"label"];
    NSArray* values = [self.plantParameters objectForKey:@"value"];
    
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
    [self.view endEditing:YES];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell.textLabel.text isEqualToString:@"Reactor Power"]){
        UISlider* theSlider =  [[UISlider alloc] initWithFrame:CGRectMake(174,12,240,23)];
        theSlider.maximumValue=10000;
        theSlider.minimumValue=0;
        theSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
        [cell addSubview:theSlider];
        UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(174, 12, 160, cell.contentView.bounds.size.height - 10)];
        cell.accessoryView = text;
        
        [theSlider addTarget:self action:@selector(reactorPowerSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    } else if([cell.textLabel.text isEqualToString:@"Mode"] ||
               [cell.textLabel.text isEqualToString:@"RCS"] ||
              [cell.textLabel.text isEqualToString:@"RCS T avg"]){
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(174, 12, 160, cell.contentView.bounds.size.height - 10)];
        [cell addSubview:textField];
        cell.accessoryView = textField;
    }
}

- (void) reactorPowerSliderValueChange: (id)sender
{
    UISlider * slider = (UISlider*)sender;
    UITableViewCell * cell = (UITableViewCell*)[slider superview];
    UILabel *label = (UILabel*)cell.accessoryView;
    label.text = [NSString stringWithFormat:@"%d", (int)round(slider.value)];
}

@end
