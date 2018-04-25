//
//  DetailViewController.m
//  Homepwner
//
//  Created by Zaur Giyasov on 24/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "ImageStore.h"

@interface DetailViewController () <UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)clearImage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearImageButton;

@end

@implementation DetailViewController

- (IBAction)takePicture:(UIBarButtonItem *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    // If has camera?
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else { // camera hasn't
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    // in screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)clearImage:(UIButton *)sender {
    [[ImageStore sharedStore] deleteImageForKey:self.item.imageKey];
    self.imageView.image = nil;
    self.clearImageButton.alpha = 0.0;
}

// TextField delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// ImagePicker delegates
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    [[ImageStore sharedStore] setImage:image forKey:self.item.imageKey];
    self.imageView.image = image;
    self.clearImageButton.alpha = 1.0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLoad {
    
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
    
    // Image Storage
    NSString *imageKey = self.item.imageKey;
    UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
    self.imageView.image = imageToDisplay;
    
    (self.imageView.image) ? (self.clearImageButton.alpha = 1.0) : (self.clearImageButton.alpha = 0.0);
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
