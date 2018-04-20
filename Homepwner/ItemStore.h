//
//  ItemStore.h
//  Homepwner
//
//  Created by Zaur Giyasov on 20/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemStore : NSObject

// Notice that this is a class method and prefixed with a + instead of a -
+(instancetype)sharedStore;

@end
