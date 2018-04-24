//
//  DetailViewController.m
//  Homepwner
//
//  Created by Zaur Giyasov on 24/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "DatePickerViewController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailViewController

// textField Delegate method
-(void)textFieldDidBeginEditing:(UITextField *)textField {

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)changeDate:(UIButton *)sender {
    DatePickerViewController *dpVC = [[DatePickerViewController alloc] init];
    dpVC.item = self.item;
    [self.navigationController pushViewController:dpVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect appRect = [[UIScreen mainScreen] bounds];
    UIToolbar *accessoryView = [[UIToolbar alloc]
                                initWithFrame:CGRectMake(0, 0, appRect.size.width, 0.1 * appRect.size.width)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                              target:nil
                              action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(selectDoneButton)];
    accessoryView.items = @[space, done];
    self.valueTextField.inputAccessoryView = accessoryView;
}

- (void)selectDoneButton {
    [self.valueTextField resignFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Item *i = self.item;
    self.nameTextField.text = i.itemName;
    self.serialTextField.text = i.serialNumber;
    self.valueTextField.text = [NSString stringWithFormat:@"%d", i.valueInDollars];
    
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    // save
    Item *i = self.item;
    i.itemName = self.nameTextField.text;
    i.serialNumber = self.serialTextField.text;
    i.valueInDollars = [self.valueTextField.text intValue];
}

-(void)setItem:(Item *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

@end
