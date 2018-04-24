//
//  Item.h
//  RandomItems
//
//  Created by Zaur Giyasov on 17/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

// Class methods
+ (instancetype)randomItem;

// Designated init
-(instancetype)initWithItemName: (NSString *)name valueInDollars: (int)value serialNumber: (NSString *)serialNum;
//
-(instancetype)initWithItemName: (NSString *)name;
-(instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)serialNum;

// Propertyes
//@property (nonatomic, strong) Item *containedItem;
//@property (nonatomic, weak) Item *container;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
//@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSDate *dateCreated;


@end

// change property type
/////////////////////////////
/* 3 - 1
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
    
    // 3 - 1
    Item *_containedItem;
    __weak Item *_container;
}

- (void)setItemName: (NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber: (NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars: (int)v;
- (int)valueInDollars;

- (NSDate *)dateCreated;

// 3 - 1
- (void)setContainedItem: (Item *)item;
- (Item *)containedItem;
- (void)setContainer: (Item *)item;
- (Item *)container;

 */
//////////////////////////////////////




