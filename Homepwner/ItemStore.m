//
//  ItemStore.m
//  Homepwner
//
//  Created by Zaur Giyasov on 20/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ItemStore.h"

@implementation ItemStore

+(instancetype)sharedStore {
    static ItemStore *sharedStore = nil;
    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

// If a programmer calls [x alloc] init]. let him know the error of his ways
-(instancetype)init {
    @throw [NSException exceptionWithName:@"This class is Singleton!" reason:@"Use [ItemStore sharedStore]" userInfo:nil];
    return nil;
}

    // Here is the real init
    // it only for Supermen and Batman :)
-(instancetype)initPrivate {
    self = [super init];
    return self;
}

@end
