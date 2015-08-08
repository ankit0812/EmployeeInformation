//
//  EditInfoViewController.h
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@property (weak, nonatomic) IBOutlet UITextField *txtEmpID;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (weak, nonatomic) IBOutlet UITextField *txtDesignation;

@property (weak, nonatomic) IBOutlet UITextField *txtDepartment;

@property (weak, nonatomic) IBOutlet UITextField *txtImage;

@property (weak, nonatomic) IBOutlet UITextField *txtTagLine;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)selectPhoto:(UIButton *)sender; // Button for selecting photos from Gallery

- (IBAction)takePhoto:(UIButton *)sender;   // Button for taking

- (IBAction)saveInfo:(id)sender;            //Save the info

- (void)saveImage:(UIImageView *)imageView imgName:(NSString *)name;    //Function to save the image




@end
