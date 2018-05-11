//
//  Item.m
//  RandomItems
//
//  Created by Zaur Giyasov on 17/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//


#import "Item.h"

//@interface Item()

//@end

@implementation Item

// Class method
+(instancetype)randomItem {
    // Create an immutable array of three adjectives
    NSArray *randomAdjectiveList = @[@"Sunny", @"Purrpurr", @"SoftBoild"];
    
    // Create an immutable array of three nouns
    NSArray *randomNounList = @[@"Smartphone", @"Monitor", @"Keyboard"];
    
    // Get the index of a random adjective/noun from the lists
    // Note: The % operator, called the modulo operator, gives
    // you the remainder. So adjectiveIndex is a random number
    // from 0 to 2 inclusive.
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];

    NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'a' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    
    Item *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

// Designated init
-(instancetype)initWithItemName: (NSString *)name valueInDollars: (int)value serialNumber: (NSString *)serialNum {
    self = [super init];
    
    if (self) {
        //set
        _itemName = name;
        _valueInDollars = value;
        _serialNumber = serialNum;
        _dateCreated = [[NSDate alloc]init];
        
        // Create an NSUUID obj - it's key!
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _imageKey = key;
    }
    return self;
}

-(instancetype)initWithItemName: (NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

-(instancetype)init {
    return [self initWithItemName:@"Item"];
}

-(instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)serialNum {
    return [self initWithItemName:name valueInDollars:0 serialNumber:serialNum];
}

// Override Description
-(NSString *)description {
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     self.itemName,
     self.serialNumber,
     self.valueInDollars,
     self.dateCreated];
    
    return descriptionString;
}

// Dealloc
-(void)dealloc {
//    NSLog(@"<Dealloc *Item>");
    NSLog(@"<Dealloc: %@>", self.description);
}

// accessors and properties
-(void)setItemName:(NSString *)itemName {
    _itemName = [itemName copy];
}

    // NSCoding:
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.imageKey forKey:@"imageKey"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _imageKey = [aDecoder decodeObjectForKey:@"imageKey"];
    }
    return self;
}

///////////////////////////////////////////////////
@end

