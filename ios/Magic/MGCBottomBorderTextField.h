//
//  MGCBottomBorderTextField.h
//  Magic
//
//  Created by Jason Scharff on 4/23/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGCBottomBorderTextField : UITextField

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

- (instancetype)initWithBorderColor:(UIColor *)color
                        borderWidth:(CGFloat)width;

@end
