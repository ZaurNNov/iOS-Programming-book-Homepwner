//
//  ImageStore.m
//  Homepwner
//
//  Created by Zaur Giyasov on 25/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation ImageStore


// Singlton
+(instancetype)sharedStore {
    static ImageStore *sharedStore = nil;
    
//    if (!sharedStore) {
//        sharedStore = [[self alloc] initPrivate];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

// hint
-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singlton" reason:@"Use [ImageStore sharedStore]" userInfo:nil];
}

// init
-(instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

    // Methods:
-(void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image; // [self.dictionary setObject:image forKey:key];
}

-(UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key]; // [self.dictionary objectForKey:key];
}

-(void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end
