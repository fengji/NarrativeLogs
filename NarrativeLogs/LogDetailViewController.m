//
//  LogDetailViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 1/11/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "LogDetailViewController.h"
#import "NarrativeLogsDataAccessService.h"

@interface LogDetailViewController ()
@end

@implementation LogDetailViewController
@synthesize delegate = _delegate;
@synthesize entryDetail = _entryDetail;
@synthesize entryId = _entryId;

- (void) setEntryDetail:(NSDictionary *)entryDetail
{
    if(_entryDetail != entryDetail){
        _entryDetail = entryDetail;
        [self.tableView reloadData];
    }
}

- (void) loadEntryDetail:(id)sender
{
    self.entryDetail = [NarrativeLogsDataAccessService logEntryDetail:sender];
}

- (NSDictionary *) entryDetail
{
    if(!_entryDetail){
        [self loadEntryDetail: self.entryId];
    }
    return _entryDetail;
    
}

- (IBAction)backToEntries:(id)sender
{
    [self.delegate dismissModalView];
}

- (void)awakeFromNib  // always try to be the split view's delegate
{
    [super awakeFromNib];
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

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    

}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    switch (section) {
        case 0:
            num = 1;
            break;
        
        case 1:
            num = 1;
            break;
            
        case 2:
            num = 3;
            break;
        
        case 3:
            num = 3;
            break;
            
        case 4:
            num = 5;
            break;
            
        default:
            break;
    }
    return num;
}

- (NSInteger) tableView:(UITableView *)tableView globalIndexAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = 0;
    NSUInteger sect = indexPath.section;
    for (NSUInteger i = 0; i < sect; ++ i)
        row += [self tableView:tableView numberOfRowsInSection:i];
    row += indexPath.row;
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    NSArray* detailLabels = [self.entryDetail objectForKey:@"entryLabels"];
    NSArray* detailValues = [self.entryDetail objectForKey:@"values"];
    //
    //The indexPath.row is always local to the section, which means
    //section 0
    //---------
    //[ row 0 ]
    //[ row 1 ]
    //[ row 2 ]
    //---------
    //section 1
    //---------
    //[ row 0 ]
    //[ row 1 ]
    //---------
    //section 2
    //---------
    //[ row 0 ]
    //[ row 1 ]
    //[ row 2 ]
    //[ row 3 ]
    //---------
    // calculate global row index:
    NSUInteger row = 0;
    NSUInteger sect = indexPath.section;
    for (NSUInteger i = 0; i < sect; ++ i)
        row += [self tableView:tableView numberOfRowsInSection:i];
    row += indexPath.row;
    
    NSString* label = [detailLabels objectAtIndex:row];
    NSString* value = [detailValues objectAtIndex:row];
    NSString *title = nil, *subtitle = nil;
    title = label;
    if([value isKindOfClass:[NSString class]]){
        subtitle =  (NSString *)value;
    }
    

    switch (indexPath.section) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            if([value isEqualToString:@"YES"]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            subtitle = @"";
            break;
        case 4:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text=subtitle;
    //
    cell.textLabel.numberOfLines = 0;
    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if(section == 1){
        return 100;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }

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
