//
//  DetailViewController.h
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/28/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *FirstName;

@property (weak, nonatomic) IBOutlet UITextField *LastName;

@property (weak, nonatomic) IBOutlet UITextField *Age;

@property (weak, nonatomic) IBOutlet UITextField *Designation;

@property (weak, nonatomic) IBOutlet UITextField *Department;

@property (weak, nonatomic) IBOutlet UITextField *TagLine;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *imageViewName;


@property (nonatomic, strong) NSString *actualFirstName;
@property (nonatomic, strong) NSString *actualLastName;
@property (nonatomic, strong) NSString *actualAge;
@property (nonatomic, strong) NSString *actualDesignation;
@property (nonatomic, strong) NSString *actualDepartment;
@property (nonatomic, strong) NSString *actualTagLine;
@property (nonatomic, strong) NSString *actualImageView;

- (UIImage *)loadImage: (NSString *)name;


@end
