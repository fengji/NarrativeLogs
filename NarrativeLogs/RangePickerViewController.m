//
//  RangePickerViewController.m
//  NarrativeLogs
//
//  Created by Feng Ji on 2/5/13.
//  Copyright (c) 2013 Feng Ji. All rights reserved.
//

#import "RangePickerViewController.h"

@interface RangePickerViewController ()

@property (nonatomic) IBOutlet UIPickerView *picker1;
@property (nonatomic) IBOutlet UIPickerView *picker2;
@property (nonatomic) IBOutlet UILabel * toLabel;
@end

@implementation RangePickerViewController

@synthesize data1 = _data1;
@synthesize data2 = _data2;
@synthesize  picker1 = _picker1;
@synthesize picker2 = _picker2;
@synthesize toLabel = _toLabel;

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
        [self.picker1 setNeedsLayout];
    }
    if(!_picker2){
        _picker2 = [[UIPickerView alloc]initWithFrame:CGRectMake(120, 12, 72, 100)];
        _picker2.tag = 2;
        self.picker2.delegate = self;
        self.picker2.dataSource = self;
        self.picker2.showsSelectionIndicator = YES;
        [self.picker2 setNeedsLayout];
    }
    if(!_toLabel){
        _toLabel = [[UILabel alloc]initWithFrame: CGRectMake(92, 100, 20, 15)];
        [self.toLabel setText:@"to"];
        [self.toLabel setNeedsLayout];
    }
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:self.picker1];
    [self.view addSubview:self.picker2];
    [self.view addSubview:self.toLabel];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setNeedsLayout];
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
