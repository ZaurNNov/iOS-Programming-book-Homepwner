//
//  ItemCell.m
//  Homepwner
//
//  Created by A1 on 11.05.2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;

@end

@implementation ItemCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self updateInterfaceForDynamicTypeSyze];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateInterfaceForDynamicTypeSyze)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.thumbnailView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1 constant:0];
    [self.thumbnailView addConstraint:constraint];
}

-(void)dealloc {
    // trust
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
    
}

-(void) updateInterfaceForDynamicTypeSyze {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumber.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                UIContentSizeCategoryExtraSmall : @40,
                                UIContentSizeCategorySmall      : @40,
                                UIContentSizeCategoryMedium     : @40,
                                UIContentSizeCategoryLarge      : @40,
                                UIContentSizeCategoryExtraLarge : @45,
                                UIContentSizeCategoryExtraExtraLarge : @55,
                                UIContentSizeCategoryExtraExtraExtraLarge : @65 };
    }
    
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *imageSize = imageSizeDictionary[userSize];
//    self.imageViewWidthConstraint.constant = imageSize.floatValue;
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
}

@end
