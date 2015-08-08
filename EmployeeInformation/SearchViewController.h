//
//  SearchViewController.h
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/28/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@property (weak, nonatomic) IBOutlet UITextField *empidValue;

@property (weak, nonatomic) IBOutlet UITextField *nameValue;
@property (weak, nonatomic) IBOutlet UITextField *designationValue;

- (IBAction)searchNameDes:(id)sender;

- (IBAction)searchButton:(id)sender;
@end
