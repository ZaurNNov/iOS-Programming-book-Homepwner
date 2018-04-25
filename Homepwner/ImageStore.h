//
//  ImageStore.h
//  Homepwner
//
//  Created by Zaur Giyasov on 25/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStore : NSObject

+(instancetype)sharedStore;
-(void)setImage: (UIImage *)image forKey: (NSString *)key;
-(UIImage *)imageForKey: (NSString *)key;
-(void)deleteImageForKey: (NSString *)key;


@end
