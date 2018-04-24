//
//  DetailViewController.m
//  Homepwner
//
//  Created by Zaur Giyasov on 24/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) NSDateFormatter *df;

@end

@implementation DetailViewController

-(void)viewDidLoad {

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Item *i = self.item;
    self.nameTextField.text = i.itemName;
    self.serialTextField.text = i.serialNumber;
    self.valueTextField.text = [NSString stringWithFormat:@"USA $: %d", i.valueInDollars];
    
    // DateFarrmatter
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    // Use dateFormatter
    self.dateLabel.text = [dateFormatter stringFromDate:i.dateCreated];
}

@end
