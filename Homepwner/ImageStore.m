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
- (NSString *)imagePathForKey: (NSString *)key;

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
        
        // clear
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearOurCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    return self;
}

    // Methods:
-(void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image; // [self.dictionary setObject:image forKey:key];
    
    // create path
    NSString *createdImagePath = [self imagePathForKey:key];
    // Turn image into JPEG data
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    // Write to disc
    [imageData writeToFile:createdImagePath atomically:YES];
    NSLog(@"Save image to: %@", createdImagePath);
    [self clearOurCache];
}

-(UIImage *)imageForKey:(NSString *)key {
    
    // if load file?
    UIImage *result = self.dictionary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        
        // create image from disc data
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        // if we found an image on the file system, place it into the cache
        if (result) {
            self.dictionary[key] = result;
        } else {
            NSLog(@"Error load image from: %@", [self imagePathForKey:key]);
        }
    }
    
    return result;
}

-(void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    // create path
    NSString *createdImagePath = [self imagePathForKey:key];
    // Delete from disc
    [[NSFileManager defaultManager] removeItemAtPath:createdImagePath error: nil];
}

// Path for image store
-(NSString *)imagePathForKey:(NSString *)key {
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [documentDirectory firstObject];
    return [docDirectory stringByAppendingPathComponent:key];
}

-(void) clearOurCache: (NSNotification *)notification {
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

-(void) clearOurCache {
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}


@end
