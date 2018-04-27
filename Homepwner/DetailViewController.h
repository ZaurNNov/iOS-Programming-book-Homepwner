//
//  DetailViewController.h
//  Homepwner
//
//  Created by Zaur Giyasov on 24/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface DetailViewController : UIViewController

-(instancetype)initForNewItem: (BOOL)isNew;
@property (nonatomic, strong) Item *item;
@property (nonatomic, copy) void (^dismissBlock) (void);

@end
