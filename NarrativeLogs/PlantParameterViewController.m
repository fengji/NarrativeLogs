//
//  PlantParameterViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 2/4/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "PlantParameterViewController.h"
#import "NarrativeLogsDataAccessService.h"
#import "UISliderWithPopover.h"
#import "RangePickerViewController.h"

@interface PlantParameterViewController () <UITextFieldDelegate, UIPopoverControllerDelegate>
@property (nonatomic, strong) UIPopoverController *poController;
@property (nonatomic, strong) UIButton * rangeButton;
@end

@implementation PlantParameterViewController
@synthesize plantParameters = _plantParameters;
@synthesize poController = _poController;
@synthesize rangeButton = _rangeButton;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.navigationItem.hidesBackButton = YES;
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
    // Do any additional setup after loading the view.
    [self handleSplitViewBarButtonItem:self.splitViewBarButtonItem];
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
        NSArray * subviews = cell.subviews;
        UISliderWithPopover* theSlider = nil;
        for(id sv in subviews){
            if([sv isKindOfClass:[UISliderWithPopover class]]){
                theSlider = sv;
                break;
            }                
        }
        
        if(!theSlider){
            
            theSlider =  [[UISliderWithPopover alloc] initWithFrame:CGRectMake(174,12,240,23)];
            theSlider.maximumValue=10000;
            theSlider.minimumValue=0;
            theSlider.unit = @"";
            theSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
            [cell addSubview:theSlider];
            
            UITextField * text = [[UITextField alloc] initWithFrame:CGRectMake(174, 12, 120, cell.contentView.bounds.size.height - 10)];
            cell.accessoryView = text;
            text.delegate = self;
            
            [theSlider addTarget:self action:@selector(reactorPowerSliderValueChange:) forControlEvents:UIControlEventValueChanged];
        }

    } else if([cell.textLabel.text isEqualToString:@"Mode"] ||
               [cell.textLabel.text isEqualToString:@"RCS"] ||
              [cell.textLabel.text isEqualToString:@"RCS T avg"]){
        NSArray * subviews = cell.subviews;
        UITextField * textField = nil;
        for(id sv in subviews){
            if([sv isKindOfClass:[UITextField class]]){
                textField = sv;
                break;
            }
        }
        if(!textField){
            textField = [[UITextField alloc] initWithFrame:CGRectMake(174, 12, 160, cell.contentView.bounds.size.height - 10)];
            [cell addSubview:textField];
            cell.accessoryView = textField;
        }
    }else if([cell.textLabel.text isEqualToString:@"<Parameter X>"]){
        NSArray * subviews = cell.subviews;
        UISliderWithPopover* theSlider = nil;
        for(id sv in subviews){
            if([sv isKindOfClass:[UISliderWithPopover class]]){
                theSlider = sv;
                break;
            }
        }
        
        if(!theSlider){
            
            theSlider =  [[UISliderWithPopover alloc] initWithFrame:CGRectMake(174,12,240,23)];
            theSlider.maximumValue=100;
            theSlider.minimumValue=0;
            theSlider.unit = @"%";
            theSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
            [cell addSubview:theSlider];
            
            UITextField * text = [[UITextField alloc] initWithFrame:CGRectMake(174, 12, 120, cell.contentView.bounds.size.height - 10)];
            cell.accessoryView = text;
            text.delegate = self;
            
            [theSlider addTarget:self action:@selector(parameterXSliderValueChange:) forControlEvents:UIControlEventValueChanged];
        }
    }else if([cell.textLabel.text isEqualToString:@"Baron Concentration"]){
        NSArray * subviews = cell.subviews;
        UIButton* button = nil;
        for(id sv in subviews){
            if([sv isKindOfClass:[UIButton class]]){
                button = sv;
                break;
            }
        }
        if(!button){
            button = [[UIButton alloc] initWithFrame:CGRectMake(174, 12, 160, cell.contentView.bounds.size.height - 10)];
            [button setTitle:@"Select Range" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell addSubview:button];
            cell.accessoryView = button;
            [button addTarget:self action:@selector(popupRangePicker:) forControlEvents:UIControlEventTouchDown];
        }
        
    }
}

- (void) reactorPowerSliderValueChange: (id)sender
{
    UISlider * slider = (UISlider*)sender;
    UITableViewCell * cell = (UITableViewCell*)[slider superview];
    UILabel *label = (UILabel*)cell.accessoryView;
    label.text = [NSString stringWithFormat:@"%d", (int)round(slider.value)];
}

- (void) parameterXSliderValueChange: (id)sender
{
    UISlider * slider = (UISlider*)sender;
    UITableViewCell * cell = (UITableViewCell*)[slider superview];
    UILabel *label = (UILabel*)cell.accessoryView;
    label.text = [NSString stringWithFormat:@"%d%%", (int)round(slider.value)];
}

// disable the textfield editing for the accessory view of the slider cell
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void) popupRangePicker: (id)sender
{
    NSLog(@"Should launch popup range picker");
    RangePickerViewController * rangePicker = [[RangePickerViewController alloc] init];
    rangePicker.rangePickerPopoverDelegate = self;
    rangePicker.contentSizeForViewInPopover = CGSizeMake(200, 220);
    
    UIButton *button = nil;
    if([sender isKindOfClass:[UIButton class]]){
        button = (UIButton*)sender;
        self.rangeButton = button;
    }
    
    [self dismissPopover];
    
    self.poController = [[UIPopoverController alloc] initWithContentViewController:rangePicker];
    self.poController.delegate=self;
    [self.poController presentPopoverFromRect:button.frame inView:[button superview] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void) dismissPopover{
    if(self.poController){
        [self.poController dismissPopoverAnimated:YES];
    }
}

- (void) updateRangeWithStart:(NSString *)start End:(NSString *)end
{
    NSLog(@"Update text for the range selected with start %@ and end %@", start, end);
    // find the button to update the text
    NSString * text = [NSString stringWithFormat:@"%@%@%@", start, @"-", end];
    [self.rangeButton setTitle:text forState:UIControlStateNormal];
    [self dismissPopover];
}

@end
