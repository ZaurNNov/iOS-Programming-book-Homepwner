//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Zaur Giyasov on 20/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ItemsViewController.h"
#import "Item.h"
#import "ItemStore.h"

@implementation ItemsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

    // Designated initializer new - init:
-(instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleValue1];
    if (self) {
        for (int i = 0; i < 10; i++) {
            [[ItemStore sharedStore] createItem];
        }
    }
    return self;
}

#pragma MARK - UITableView Data & style

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[[ItemStore sharedStore] itemsMidMax] count];
            break;
        case 1:
            return [[[ItemStore sharedStore] itemsMinMid] count];
            break;
            
        default: return [[[ItemStore sharedStore] allItems] count];
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"items from Mid <-> Max values";
//            break;
        case 1:
            return @"items from Min <-> Mid values";
            break;
            
        default: return @"All items values";
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    // 3 section
    
    if (indexPath.section == 0) { // items from Mid <-> Max values
        NSArray *arr = [[ItemStore sharedStore] itemsMidMax];
        Item *i = arr[indexPath.row];
        cell.textLabel.text = i.description;
        NSString *val = [NSString stringWithFormat:@"Value: %d", i.valueInDollars];
        cell.detailTextLabel.text = val;
        
    } else if (indexPath.section == 1) {// items from Min <-> Mid values
        NSArray *arr = [[ItemStore sharedStore] itemsMinMid];
        Item *i = arr[indexPath.row];
        cell.textLabel.text = i.description;
        NSString *val = [NSString stringWithFormat:@"Value: %d", i.valueInDollars];
        cell.detailTextLabel.text = val;
        
    } else { // All items values
        NSArray *arr = [[ItemStore sharedStore] allItems];
        Item *i = arr[indexPath.row];
        cell.textLabel.text = i.description;
        NSString *val = [NSString stringWithFormat:@"Value: %d", i.valueInDollars];
        cell.detailTextLabel.text = val;
    }
    
    return cell;
}

@end
