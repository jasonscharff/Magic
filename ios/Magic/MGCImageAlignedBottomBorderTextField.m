//
//  MGCImageAlignedBottomBorderTextField.m
//  Magic
//
//  Created by Jason Scharff on 4/25/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import "MGCImageAlignedBottomBorderTextField.h"

#import "AutolayoutHelper.h"

#import "MGCBottomBorderTextField.h"

@interface MGCBottomBorderTextField()

@end

@implementation MGCImageAlignedBottomBorderTextField

-(instancetype)initWithImage : (UIImage *)image bottomBorderColor : (UIColor *)color borderWidth : (CGFloat)width {
  self = [super init];
  self.textField = [[MGCBottomBorderTextField alloc]initWithBorderColor:color borderWidth:width];
  [self commonInit];
  self.iconImageView.image = image;
  return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self commonInit];
  return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  [self commonInit];
  return self;
}

-(void)commonInit {
  self.translatesAutoresizingMaskIntoConstraints = YES;
  self.iconImageView = [[UIImageView alloc]init];
  self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
  if(!_textField) {
    self.textField = [[MGCBottomBorderTextField alloc]initWithBorderColor:[UIColor blackColor]
                                                              borderWidth:1.0f];
  }
  
  NSLayoutConstraint *ratio = [NSLayoutConstraint constraintWithItem:self.iconImageView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.iconImageView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0
                                                            constant:0];
  
  [AutolayoutHelper configureView:self
                         subViews:NSDictionaryOfVariableBindings(_textField, _iconImageView)
                      constraints:@[@"H:|[_iconImageView]-[_textField]|",
                                    @"X:_iconImageView.top ==_textField.top",
                                    @"X:_iconImageView.bottom == _textField.bottom",
                                    @"V:|[_textField]|"]];
  [self addConstraint:ratio];
}

@end
