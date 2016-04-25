//
//  MGCSearchViewController.m
//  Magic
//
//  Created by Jason Scharff on 4/20/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

#import "MGCSearchViewController.h"

#import "AutolayoutHelper.h"
#import "MGCBottomBorderTextField.h"
#import "MGCItemDetailViewController.h"
#import "Magic-Swift.h"

@interface MGCSearchViewController () <UITextFieldDelegate, UITableViewDelegate, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UIImageView *searchImage;
@property (nonatomic, strong) MGCBottomBorderTextField *searchField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MGCTableViewDataSource *dataHandler;
@property (nonatomic, strong) MGCItemDetailViewController *detailVC;
@property (nonatomic, strong) id previewingContext;



@end

@implementation MGCSearchViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self addSearchBar];
  [self configureTableView];
  if ([self isForceTouchAvailable]) {
    self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];
  }
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)configureTableView {
  self.tableView = [[UITableView alloc]init];
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100;
  self.dataHandler = [[MGCTableViewDataSource alloc]initWithTableView:self.tableView];
  self.tableView.dataSource = self.dataHandler;
  self.tableView.delegate = self;
  [AutolayoutHelper configureView:self.view subViews:NSDictionaryOfVariableBindings(_tableView, _searchField) constraints:@[@"H:|[_tableView]|",
                                                                                                              @"V:[_searchField]-[_tableView]|"]];
   
}

- (void)addSearchBar {
  self.searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon"]];
  self.searchImage.contentMode = UIViewContentModeScaleAspectFit;
  self.searchField = [[MGCBottomBorderTextField alloc]initWithBorderColor:[UIColor blackColor]
                                                              borderWidth:1/[UIScreen mainScreen].scale];
  
  NSLayoutConstraint *ratio = [NSLayoutConstraint constraintWithItem:self.searchImage
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchImage
                                                           attribute:NSLayoutAttributeHeight
                                                           multiplier:1.0
                                                           constant:0];
  
  self.searchField.placeholder = @"Search for";
  self.searchField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.searchField.delegate = self;
  [self.searchField addTarget:self
                action:@selector(textFieldDidChange:)
      forControlEvents:UIControlEventEditingChanged];
  
  [AutolayoutHelper configureView:self.view
                         subViews:NSDictionaryOfVariableBindings(_searchField, _searchImage)
                        constraints:@[@"H:|-[_searchImage]-[_searchField]-|",
                                      @"V:|-10-[_searchImage(25)]",
                                      @"X:_searchField.bottom == _searchImage.bottom"]];
  [self.view addConstraint:ratio];
  
}

- (void)textFieldDidChange : (UITextField *)textField {
  if(textField.text && ![textField.text isEqualToString:@""]) {
    [_dataHandler executeSearch:textField.text];
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if(!_detailVC) {
    _detailVC = [[MGCItemDetailViewController alloc]init];
  }
  _detailVC.item = [self.dataHandler getItemForIndexPath:indexPath];
  [self.navigationController pushViewController:_detailVC animated:YES];
}

#pragma mark 3D touch

- (void)previewingContext:(id )previewingContext commitViewController: (UIViewController *)viewControllerToCommit {
  [self.navigationController showViewController:viewControllerToCommit sender:nil];
}

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
  if(!_detailVC) {
    _detailVC = [[MGCItemDetailViewController alloc]init];
  }
  CGPoint cellPostion = [self.tableView convertPoint:location fromView:self.view];
  NSIndexPath *path = [self.tableView indexPathForRowAtPoint:cellPostion];
  _detailVC.item = [self.dataHandler getItemForIndexPath:path];
  UITableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:path];
  previewingContext.sourceRect = [self.view convertRect:tableCell.frame fromView:self.tableView];
  return _detailVC;
}

- (BOOL)isForceTouchAvailable {
  BOOL isForceTouchAvailable = NO;
  if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
    isForceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
  }
  return isForceTouchAvailable;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  if ([self isForceTouchAvailable]) {
    if (!self.previewingContext) {
      self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
  } else {
    if (self.previewingContext) {
      [self unregisterForPreviewingWithContext:self.previewingContext];
      self.previewingContext = nil;
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
