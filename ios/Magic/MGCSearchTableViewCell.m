//
//  MGCSearchTableViewCell.m
//  Magic
//
//  Created by Jason Scharff on 4/24/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import "MGCSearchTableViewCell.h"

@import Haneke;

#import "AutolayoutHelper.h"
#import "Magic-Swift.h"

@interface MGCSearchTableViewCell()

@property (nonatomic, strong) UILabel *storeLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *coverImage;

@end

@implementation MGCSearchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  self.itemLabel = [UILabel new];
  self.itemLabel.font = [UIFont fontWithName:@"AvenirNext-Demibold" size:14.0f];
  self.storeLabel = [UILabel new];
  self.storeLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
  self.addressLabel = [UILabel new];
  self.addressLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12.0];
  self.coverImage = [UIImageView new];
  self.coverImage.contentMode = UIViewContentModeScaleAspectFit;
  [self setConstraints];
  return self;
}


- (void)setConstraints {
  [AutolayoutHelper configureView:self.contentView
                         subViews:NSDictionaryOfVariableBindings(_storeLabel, _itemLabel, _coverImage, _addressLabel)
                         constraints:@[@"H:|-[_coverImage]-[_itemLabel]",
                                       @"X:_storeLabel.leading == _itemLabel.leading",
                                       @"X:_addressLabel.leading == _itemLabel.leading",
                                       @"X:_addressLabel.trailing <= superview.trailing - 8",
                                       @"V:|-[_coverImage]-|",
                                       @"X:_coverImage.height == _coverImage.width",
                                       @"V:|-[_itemLabel]-2-[_storeLabel]-2-[_addressLabel]-(>=8)-|"]];
}

-(void)setItem:(MGCItem *)item {
  _item = item;
  [self.contentView layoutIfNeeded];
  self.storeLabel.text = item.locationName;
  self.itemLabel.text = item.itemName;
  [self.coverImage hnk_setImageFromURL:item.coverImageURL];
  self.addressLabel.text = item.addressString;
  
  
  
}



@end
