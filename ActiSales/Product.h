//
//  NSObject+Product.h
//  ActiSales
//
//  Created by Noirdemort on 19/10/21.
//

#import <Foundation/Foundation.h>


@interface Product: NSObject

/* USE IF MORE OPERATIONS NEED TO BE ADDED
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* country;
@property (nonatomic) NSNumber* price;
*/

+(NSDictionary*) getProductCatalogue;

@end
