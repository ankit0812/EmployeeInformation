//
//  EditInfoViewController.h
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end


@interface EditInfoViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtEmpID;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (weak, nonatomic) IBOutlet UITextField *txtDesignation;

@property (weak, nonatomic) IBOutlet UITextField *txtDepartment;

@property (weak, nonatomic) IBOutlet UITextField *txtImage;

@property (weak, nonatomic) IBOutlet UITextField *txtTagLine;

@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegate;



- (IBAction)saveInfo:(id)sender;

@end
