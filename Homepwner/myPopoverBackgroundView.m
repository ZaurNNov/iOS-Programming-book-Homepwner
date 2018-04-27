//
//  myPopoverBackgroundView.m
//  Homepwner
//
//  Created by Zaur Giyasov on 27/04/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "myPopoverBackgroundView.h"

@implementation myPopoverBackgroundView

@synthesize arrowDirection = _arrowDirection;
@synthesize arrowOffset = _arrowOffset;


+(CGFloat)arrowBase {
    return 0;
}

+(CGFloat)arrowHeight {
    return 0;
}

+(UIEdgeInsets)contentViewInsets {
    return UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

@end
