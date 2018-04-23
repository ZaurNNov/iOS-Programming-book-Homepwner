//
//  ItemStore.h
//  Homepwner
//
//  Created by Zaur Giyasov on 20/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

// Notice that this is a class method and prefixed with a + instead of a -
+(instancetype)sharedStore;
-(Item *)createItem;
-(void)removeItem: (Item *)item;

@end
