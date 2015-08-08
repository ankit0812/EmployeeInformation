//
//  EditInfoViewController.m
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "EditInfoViewController.h"
#import "DBManager.h"


@interface EditInfoViewController ()

@property (nonatomic, strong) DBManager *dbManager;         //Creating object of the DBManager

@end

@implementation EditInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.txtEmpID.delegate = self;
    self.txtFirstName.delegate = self;
    self.txtLastName.delegate = self;
    self.txtAge.delegate = self;
    self.txtDesignation.delegate = self;
    
    self.txtDepartment.delegate = self;
    self.txtImage.delegate = self;
    self.txtTagLine.delegate = self;
    
    _scroller.delegate=self;
    [_scroller setShowsHorizontalScrollIndicator:NO];
    
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"empdb.sqlite"];     //initializing access with the database
    
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.scroller addGestureRecognizer:yourTap];
    [self.view addSubview:_scroller];
    [self.scroller setScrollEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

}

float oldX; // here or better in .h interface

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveInfo:(id)sender     //Definition for save info button
{
    
    NSString *names=self.txtEmpID.text;
    NSString *namePlusExtension = [names stringByAppendingString:@".jpg"];
    
    // Prepare the query string.
    
    NSString *query = [NSString stringWithFormat:@"insert into empInfo values(%d,'%@','%@','%@','%@', '%@', '%@','%@')", [self.txtEmpID.text intValue], self.txtFirstName.text,self.txtLastName.text,self.txtAge.text,self.txtDesignation.text,self.txtDepartment.text,namePlusExtension,self.txtTagLine.text];
    
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    
    //Saving image associated to the documents location
    [self saveImage:_imageView imgName:namePlusExtension];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0)
    {
        
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
        
        NSString *exec;
        
        exec = [NSString stringWithFormat:@"%@\n%@\n%@",
                 @"Entry Successful",
                 @"Added Data to Database",
                 @"Thank You"];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:exec
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
    }
    // If the query was not executed
    else
    {
        NSString *error;
        
        error = [NSString stringWithFormat:@"%@\n%@ %@\n%@",
                    @"Violating Constraints",
                    @"EmpID already exists",
                    @"DB Error",
                    @"Try Again"];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:error
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        
        NSLog(@"Could not execute the query.");
    }

}

- (IBAction)takePhoto:(UIButton *)sender
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil                                                                                                                                                                                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else
    {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    }
}

// Function for selecting photos from gallery using UIImagePickerControllerSourceTypePhotoLibrary

- (IBAction)selectPhoto:(UIButton *)sender
{
  
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

}


//Use of Delegates of Image Picker Controller

#pragma mark - Image Picker Controller delegate methods

//Choose Images from gallery

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

// Cancel choosing images

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//Definition for saving images

- (void)saveImage: (UIImageView *)imageView imgName:(NSString *)name
{
    if (imageView != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          name];
        UIImage *img=imageView.image;
        
        NSData* data = UIImagePNGRepresentation(img);

        [data writeToFile:path atomically:YES];
    }
}


- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer{
    
    [self.view endEditing:YES];
}

// Dismiss keyboard on return

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma - Deals with adjusting the keyboard with the screen show that if a text box is selected keyboard moves down

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
    
    
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    CGPoint scrollPoint;

 if (!CGRectContainsPoint(aRect, _txtLastName.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _txtLastName.frame.origin.y - (keyboardSize.height));
    }
    else if ( !CGRectContainsPoint(aRect, _txtAge.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _txtAge.frame.origin.y - (keyboardSize.height));
    }
    else if (  !CGRectContainsPoint(aRect, _txtDepartment.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _txtDepartment.frame.origin.y - (keyboardSize.height));
    }
    else if (!CGRectContainsPoint(aRect, _txtDesignation.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _txtDesignation.frame.origin.y - (keyboardSize.height));
    }
    else if (!CGRectContainsPoint(aRect, _txtTagLine.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _txtTagLine.frame.origin.y - (keyboardSize.height));
    }

    
    [_scroller setContentOffset:scrollPoint animated:YES];
    
    //_scroller.contentOffset = CGPointMake(0, [_scroller convertPoint:CGPointZero fromView:textField].y - 60);
    
    
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
}


/*- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _txtAge = textField;
    _txtDepartment = textField;
    _txtDesignation= textField;
    _txtEmpID = textField;
    _txtFirstName = textField;
    _txtLastName = textField;
    _txtTagLine= textField;
    _txtImage = textField;
    
    
}*/

/*- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _txtAge = nil;
    _txtDepartment = nil;
    _txtDesignation= nil;
    _txtEmpID = nil;
    _txtFirstName = nil;
    _txtLastName = nil;
    _txtTagLine= nil;
    _txtImage = nil;
}*/

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0  ||  scrollView.contentOffset.x < 0 )
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}


@end
