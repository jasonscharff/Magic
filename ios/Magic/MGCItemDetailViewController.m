//
//  MGCItemDetailViewController.m
//  Magic
//
//  Created by Jason Scharff on 4/24/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import "MGCItemDetailViewController.h"

#import "AutolayoutHelper.h"
#import "Magic-Swift.h"

@import Haneke;
@import MapKit;

static CGFloat delta = .025;

@interface MGCItemDetailViewController()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKPointAnnotation *mapAnnotation;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, strong) UIButton *uberButton;
@property (nonatomic, strong) UIImageView *yelpStars;


@property (nonatomic, strong) NSLayoutConstraint *descriptionHeightZero;

@end

@implementation MGCItemDetailViewController


-(void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.mapView = [[MKMapView alloc]init];
  self.mapAnnotation = [[MKPointAnnotation alloc]init];
  self.itemLabel = [UILabel new];
  self.descriptionLabel = [UILabel new];
  self.addressLabel = [UILabel new];
  self.addressLabel.textAlignment = NSTextAlignmentCenter;
  self.orderButton = [UIButton new];
  self.yelpStars = [UIImageView new];
  self.yelpStars.contentMode = UIViewContentModeScaleAspectFit;
  self.mapAnnotation = [[MKPointAnnotation alloc]init];
  self.uberButton = [UIButton new];
  [self.uberButton setImage:[UIImage imageNamed:@"uber"] forState:UIControlStateNormal];
  self.uberButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.locationLabel = [UILabel new];
  self.addressLabel = [UILabel new];
  [self addConstraints];
  if(_item) {
    [self setItem:_item];
  }
}

-(void)addConstraints {
  self.descriptionHeightZero = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1
                                                            constant:0];
  [AutolayoutHelper configureView:self.view
                         subViews:NSDictionaryOfVariableBindings(_mapView, _itemLabel, _descriptionLabel, _orderButton, _uberButton, _yelpStars, _locationLabel, _addressLabel)
                         constraints:@[@"H:|[_mapView]|",
                                       @"X:_itemLabel.centerX == superview.centerX",
                                       @"X:_itemLabel.trailing <= superview.trailing - 8",
                                       @"X:_descriptionLabel.centerX == superview.centerX",
                                       @"X:_descriptionLabel.trailing <= superview.trailing - 8",
                                       @"X:_orderButton.centerX == superview.centerX",
                                       @"X:_uberButton.centerX == superview.centerX",
                                       @"X:_locationLabel.centerX == superview.centerX",
                                       @"X:_locationLabel.trailing <= superview.trailing - 8",
                                       @"X:_yelpStars.centerX == superview.centerX",
                                       @"H:|-30-[_addressLabel]-30-|",
                                       @"V:|[_mapView]-[_locationLabel]-[_addressLabel]-[_itemLabel]-[_descriptionLabel]-[_yelpStars(20)]-[_orderButton(40)]-[_uberButton(==_orderButton)]-(>=8)-|"]];
  
  NSLayoutConstraint *mapViewRatio = [NSLayoutConstraint constraintWithItem:self.mapView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view attribute: NSLayoutAttributeHeight
                                                                  multiplier:0.33
                                                                  constant:0];
  
  [self.view addConstraint:mapViewRatio];
  
                                       
}

-(void)setItem:(MGCItem *)item {
  _item = item;
  if(!self.itemLabel) { //Checks if view has loaded.
    return;
  }
  [self.view layoutIfNeeded];
  if(item.itemDescription && ![item.itemDescription isEqualToString:@""]) {
    [self.view addConstraint:self.descriptionHeightZero];
  }
  else {
    self.descriptionLabel.text = item.itemDescription;
    [self.view removeConstraint:self.descriptionHeightZero];
  }
  self.itemLabel.text = item.itemName;
  self.addressLabel.text = item.addressString;
  self.locationLabel.text = item.locationName;
  HNKCacheFormat *format = [[HNKCacheFormat alloc] initWithName:@"fullscreen"];
  format.size = CGSizeMake(1881, 1496); //Put whatever you want here, it will be ignored. I put here my expected size
  format.scaleMode = HNKScaleModeNone;
  format.diskCapacity = 10000 * 1024 * 1024; // 10GB
  format.preloadPolicy = HNKPreloadPolicyLastSession;
  _yelpStars.hnk_cacheFormat = format;
  //_orderButton.imageView.hnk_cacheFormat = format;
  [self.orderButton hnk_setImageFromURL:item.itemBuyImageURL forState:UIControlStateNormal];
  [self.yelpStars hnk_setImageFromURL:item.yelpObject.imageURL];
  MKCoordinateRegion mapRegion;
  mapRegion.center.longitude = item.location.coordinate.longitude;
  mapRegion.center.latitude = item.location.coordinate.latitude;
  mapRegion.span.latitudeDelta = delta;
  mapRegion.span.longitudeDelta = delta;
  [_mapView setRegion:mapRegion animated: YES];
  self.mapAnnotation.coordinate = item.location.coordinate;
  [self.mapView addAnnotation:self.mapAnnotation];
  
  
}

@end
