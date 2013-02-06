//
//  RangePickerViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 2/5/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "RangePickerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RangePickerViewController ()

@property (nonatomic) IBOutlet UIPickerView *picker1;
@property (nonatomic) IBOutlet UIPickerView *picker2;
@property (nonatomic) IBOutlet UILabel * toLabel;
@property (nonatomic)  UIButton * cancelButton;
@property (nonatomic)  UIButton* okButton;

@end

@implementation RangePickerViewController

@synthesize data1 = _data1;
@synthesize data2 = _data2;
@synthesize  picker1 = _picker1;
@synthesize picker2 = _picker2;
@synthesize toLabel = _toLabel;
@synthesize cancelButton = _cancelButton;
@synthesize okButton = _okButton;
@synthesize rangePickerPopoverDelegate = _rangePickerPopoverDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.data1 = [NSArray arrayWithObjects: @"0" , @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.data2 = [NSArray arrayWithObjects: @"0" , @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    if(!_picker1){
        _picker1 = [[UIPickerView alloc]initWithFrame:CGRectMake(10, 12, 72, 100)];
        _picker1.tag = 1;
        self.picker1.delegate = self;
        self.picker1.dataSource = self;
        self.picker1.showsSelectionIndicator = YES;
    }
    if(!_picker2){
        _picker2 = [[UIPickerView alloc]initWithFrame:CGRectMake(120, 12, 72, 100)];
        _picker2.tag = 2;
        self.picker2.delegate = self;
        self.picker2.dataSource = self;
        self.picker2.showsSelectionIndicator = YES;
    }
    if(!_toLabel){
        _toLabel = [[UILabel alloc]initWithFrame: CGRectMake(92, 100, 20, 15)];
        [self.toLabel setText:@"to"];
    }
    
    if(!_cancelButton){
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(22, 180, 70, 30)];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_cancelButton layer] setCornerRadius:4.5f];
        [[_cancelButton layer] setBorderWidth:1.0f];
        [[_cancelButton layer] setBorderColor:[UIColor blackColor].CGColor];
        [_cancelButton setBackgroundColor:[UIColor grayColor]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchDown];
    }

    if(!_okButton){
        _okButton = [[UIButton alloc] initWithFrame:CGRectMake(112, 180, 70, 30)];
        [_okButton setTitle:@"OK" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_okButton layer] setBorderWidth:1.0f];
        [[_okButton layer] setCornerRadius:4.5f];
        [[_okButton layer] setBorderColor:[UIColor blackColor].CGColor];
        [_okButton setBackgroundColor:[UIColor grayColor]];
        [_okButton addTarget:self action:@selector(okButtonClicked:) forControlEvents:UIControlEventTouchDown];

    }
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 220)];
    [self.view addSubview:self.picker1];
    [self.view addSubview:self.picker2];
    [self.view addSubview:self.toLabel];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.okButton];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setNeedsLayout];
}

- (void) okButtonClicked: (id)sender
{
    // find value in the pickers
    NSInteger row1 = [self.picker1 selectedRowInComponent:0];
    NSInteger row2 = [self.picker2 selectedRowInComponent:0];
    NSString * start = [self.data1 objectAtIndex:row1];
    NSString * end = [self.data2 objectAtIndex:row2];
    // call delegate to update and dismiss popover
    [self.rangePickerPopoverDelegate updateRangeWithStart:start End:end];
}

- (void) cancelButtonClicked: (id) sender
{
    // call delegate to dismiss popover
    [self.rangePickerPopoverDelegate dismissPopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag == 1){
        return [self.data1 count];
    }else{
        return [self.data2 count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 1){
        return [self.data1 objectAtIndex:row];
    }else{
        return [self.data2 objectAtIndex:row];
    }
}


@end
