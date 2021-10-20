//
//  ViewController.m
//  ActiSales
//
//  Created by Noirdemort on 19/10/21.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *productPicker;

@property (weak, nonatomic) IBOutlet UILabel *selectedProductLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxSalesLabel;

@property (weak, nonatomic) IBOutlet UISwitch *autoUpdateSwitch;

@property (strong, nonatomic) NSDictionary *products;
@property (strong, nonatomic) NSArray *productNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.productPicker.delegate = self;
    self.productPicker.dataSource = self;
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.productNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.productNames[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedProductLabel.text = self.productNames[row];
    
    if ([self.autoUpdateSwitch isOn]) {
        [self didTapStatsButton:NULL];
    }
}



@end
