//
//  ItemStore.m
//  Homepwner
//
//  Created by Zaur Giyasov on 20/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"
#import "ImageStore.h"

@interface ItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

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
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

-(NSArray *)allItems {
    return self.privateItems;
}

// CREATE DELETE MOOVE

-(Item *)createItem {
//    Item *item = [Item randomItem];
    Item *item = [[Item alloc] init];
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem:(Item *)item {
    NSString *key = item.imageKey;
    [[ImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    Item *i = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:i atIndex:toIndex];
}

// Store to disk
-(NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

-(BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    NSLog(@"%@", path);
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}



@end
