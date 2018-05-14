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
#import "DetailViewController.h"
#import "ItemCell.h"
#import "ImageStore.h"
#import "ImageViewController.h"

@interface ItemsViewController() <UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) UIPopoverController *imagePopover;

@end

@implementation ItemsViewController

//-(UIView *)headerView {
//    if (!_headerView) {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}

-(void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // Load xib
    UINib *nib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
    // Register xib
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ItemCell"];
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTableViewForDynamicTypeSize]; //also tableView reload data
}

    // Designated initializer new - init:
-(instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *naviItem = self.navigationItem;
        naviItem.title = @"Homepwner";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        naviItem.rightBarButtonItem = bbi;
        naviItem.leftBarButtonItem = self.editButtonItem;
        
        // observer font chages
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(updateTableViewForDynamicTypeSize)
                              name:UIContentSizeCategoryDidChangeNotification
                            object:nil];
    }
    return self;
}

-(void)dealloc {
    // trust
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
    NSLog(@"ItemsViewController %@", NSStringFromSelector(_cmd));
}

#pragma MARK - UITableView Data & style

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // create default cell & cell ID
//    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    // get a new or recycled cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

    // get new recycled cell
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *item = items[indexPath.row];
    
    // configure cell
    cell.nameLabel.text = item.itemName;
    cell.serialNumber.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    cell.imageView.image = item.thumbnail;
    
    __weak ItemCell *weakCell = cell;
    
    cell.actionBlock = ^{
        NSLog(@"Going to show image for %@", item);
        ItemCell *strongCell = weakCell;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            NSString *imageKey = item.imageKey;
            UIImage *img = [[ImageStore sharedStore] imageForKey:imageKey];
            if (!img) {
                return;
            }
                // Make a rectangle for the frame of the thumbnail relative to
                // our table view
                // Note: there will be a warning on this line that we'll soon discuss
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds
                                        fromView:strongCell.thumbnailView];
            
                // Create a new BNRImageViewController and set its image
            ImageViewController *ivc = [[ImageViewController alloc] init];
            ivc.image = img;
            
                // Present a 600x600 popover from the rect
            self.imagePopover = [[UIPopoverController alloc]
                                 initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect
                                               inView:self.view
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        }
    };

    return cell;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePopover = nil;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *i = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:i];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *dvc = [[DetailViewController alloc] initForNewItem:NO];
    
    // Data transfer
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *selected = items[indexPath.row];
    dvc.item = selected;
    
    [self.navigationController pushViewController:dvc animated:YES];
}

// Actions
-(IBAction)addNewItem:(id)sender {
    Item *new = [[ItemStore sharedStore] createItem];
    
    // random Item
//    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:new];
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // self created item
    DetailViewController *detailVC = [[DetailViewController alloc] initForNewItem:YES];
    detailVC.item = new;
    detailVC.dismissBlock = ^{
        [self.tableView reloadData];
    };
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:detailVC];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - Style
-(void)updateTableViewForDynamicTypeSize {
    static NSDictionary *cellHeightDictionary;
    if (!cellHeightDictionary) {
        cellHeightDictionary = @{
                                 UIContentSizeCategoryExtraSmall: @44,
                                 UIContentSizeCategorySmall     : @44,
                                 UIContentSizeCategoryMedium    : @44,
                                 UIContentSizeCategoryLarge     : @44,
                                 UIContentSizeCategoryExtraLarge: @55,
                                 UIContentSizeCategoryExtraExtraLarge: @65,
                                 UIContentSizeCategoryExtraExtraExtraLarge: @75 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *cellHeight = cellHeightDictionary[userSize];
    [self.tableView setRowHeight:cellHeight.floatValue];
    [self.tableView reloadData];
}

@end
