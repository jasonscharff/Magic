//
//  MGCImageAlignedBottomBorderTextField.h
//  Magic
//
//  Created by Jason Scharff on 4/25/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGCBottomBorderTextField;

@interface MGCImageAlignedBottomBorderTextField : UIView

@property (nonatomic, strong) MGCBottomBorderTextField *textField;
@property (nonatomic, strong) UIImageView *iconImageView;

-(instancetype)initWithImage : (UIImage *)image bottomBorderColor : (UIColor *)color borderWidth : (CGFloat)width;

@end
