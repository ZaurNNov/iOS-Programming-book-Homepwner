//
//  Item.h
//  RandomItems
//
//  Created by Zaur Giyasov on 17/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>

// Class methods
+ (instancetype)randomItem;

// Designated init
-(instancetype)initWithItemName: (NSString *)name valueInDollars: (int)value serialNumber: (NSString *)serialNum;
//
-(instancetype)initWithItemName: (NSString *)name;
-(instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)serialNum;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

// for store Images
@property (nonatomic, copy) NSString *imageKey;

@end
