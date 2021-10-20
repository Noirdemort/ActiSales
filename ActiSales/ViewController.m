//
//  ViewController.m
//  ActiSales
//
//  Created by Noirdemort on 19/10/21.
//

#import "ViewController.h"
#import "Product.h"

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
    
    self.products = [Product getProductCatalogue];
    self.productNames = [self.products allKeys];
    
    self.productPicker.delegate = self;
    self.productPicker.dataSource = self;
}


/// Selects the country with highest sales if the product is selected.
/// @param sender element calling the function
- (IBAction)didTapStatsButton:(id)sender {
    
    if (self.selectedProductLabel.text == NULL) {
        return;
    }
    
    // IF MORE STATS FUNCTIONS ARE TO BE INTRODUCED, PERFORM OPERATION IN A DIFFERENT SPACE
    // INSTEAD OF FILLING THIS VIEW CONTROLLER.
    
    NSDictionary<NSString*, NSNumber*> *productStats = [self.products valueForKey:self.selectedProductLabel.text];
    
    if (productStats == NULL) {
        
        UIAlertController* alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:@"Select a product first!"
                                              preferredStyle:UIAlertControllerStyleAlert];

        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK!"
                                        style:UIAlertActionStyleDefault
                                        handler:NULL];
        
        [alertController addAction:defaultAction];
        
        [self presentViewController:alertController animated:YES completion:NULL];
        
        return;
    }
    
    NSString* country;
    double price = 0;
    
    for (NSString* name in productStats) {
        double tempPrice = [[productStats valueForKey:name] integerValue];
        
        if (tempPrice > price) {
            country = name;
            price = tempPrice;
        }
    }
    
    NSLog(@"Sample %@ %@: %.2f", self.selectedProductLabel.text, country, price);
    
    self.maxSalesLabel.text = [NSString stringWithFormat:@"%@: %.2f", country, price];
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
