//
//  NSObject+Product.m
//  ActiSales
//
//  Created by Noirdemort on 19/10/21.
//

#import "Product.h"

@implementation Product

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSDictionary*)getProductCatalogue {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"input_ios" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // Transform JSON
    NSDictionary* sales = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    // Products List
    NSArray* products = [sales objectForKey:@"sales"];
    
    // { "<Product Name>": {"<Country Name>": <Total Revenue>} }
    NSMutableDictionary<NSString*, NSDictionary*> *catalogue = [NSMutableDictionary new];
    
    for (NSDictionary* product in products) {
        
        NSString* productName = [product valueForKey:@"prod"];
        NSString* country = [product valueForKey:@"country"];
        NSNumber* price = [product valueForKey:@"price"];
        
        // {"<Country Name>": <Total Revenue>}
        NSDictionary<NSString*, NSNumber*> *record = [catalogue valueForKey:productName];
        
        // If Product does not exist yet
        if (record == NULL) {
            
            // Add first record for country
            record = [NSMutableDictionary new];
            [record setValue:price forKey:country];
            
        } else {
            
            // country does not exist for a specific product
            if ([record valueForKey:country] == NULL) {
                [record setValue:price forKey:country];
            } else {
                // Update price with current price
                price = [NSNumber numberWithInteger:([[record valueForKey:country] integerValue] + [price integerValue])];
                
                [record setValue:price forKey:country];
            }
        }
        
        [catalogue setValue:record forKey:productName];
    }
    
    return catalogue;
}

@end
