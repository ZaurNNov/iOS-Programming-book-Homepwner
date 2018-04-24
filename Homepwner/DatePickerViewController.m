//
//  DatePickerViewController.m
//  Homepwner
//
//  Created by Zaur Giyasov on 24/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "DatePickerViewController.h"
#import "Item.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.item.dateCreated = self.datePicker.date;
}

@end
