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
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *coverImage;

@end

@implementation MGCSearchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  self.storeLabel = [UILabel new];
  self.itemLabel = [UILabel new];
  self.descriptionLabel = [UILabel new];
  self.coverImage = [UIImageView new];
  self.addressLabel = [UILabel new];
  [self setConstraints];
  return self;
}


- (void)setConstraints {
  [AutolayoutHelper configureView:self.contentView
                         subViews:NSDictionaryOfVariableBindings(_storeLabel, _itemLabel, _coverImage, _addressLabel)
                         constraints:@[@"H:|-[_coverImage]-[_itemLabel]",
                                       @"X:_storeLabel.leading == _itemLabel.leading",
                                       @"X:_addressLabel.leading == _itemLabel.leading",
                                       @"V:|-[_coverImage]-|",
                                       @"X:_coverImage.height == _coverImage.width",
                                       @"V:|-[_itemLabel]-[_storeLabel]-[_addressLabel]-|"]];
}

-(void)setItem:(MGCItem *)item {
  _item = item;
  [self.contentView layoutIfNeeded];
  self.storeLabel.text = item.locationName;
  self.itemLabel.text = item.itemName;
  self.descriptionLabel.text = item.itemDescription;
  [self.coverImage hnk_setImageFromURL:item.coverImageURL];
  self.addressLabel.text = item.addressString;
  
  
  
}



@end
