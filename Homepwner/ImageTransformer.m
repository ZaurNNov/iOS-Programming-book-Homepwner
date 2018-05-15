//
//  ImageTransformer.m
//  Homepwner
//
//  Created by Zaur Giyasov on 15/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ImageTransformer.h"

@implementation ImageTransformer

+(Class)transformedValueClass {
    return [NSData class];
}

-(id)transformedValue:(id)value {
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value {
    return [UIImage imageWithData:value];
}

@end
