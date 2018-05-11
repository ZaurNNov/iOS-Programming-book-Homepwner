//
//  ItemCell.m
//  Homepwner
//
//  Created by A1 on 11.05.2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

@end
