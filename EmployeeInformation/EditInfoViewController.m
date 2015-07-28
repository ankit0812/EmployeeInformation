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

@property (nonatomic, strong) DBManager *dbManager;

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
    
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"empdb.sqlite"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveInfo:(id)sender
{
    NSString *name=self.txtEmpID.text;
    NSString *namePlusExtension = [name stringByAppendingString:@".jpg"];
    // Prepare the query string.
    
    NSString *query = [NSString stringWithFormat:@"insert into empInfo values(%d,'%@','%@','%@','%@', '%@', '%@','%@')", [self.txtEmpID.text intValue], self.txtFirstName.text,self.txtLastName.text,self.txtAge.text,self.txtDesignation.text,self.txtDepartment.text,namePlusExtension,self.txtTagLine.text];
    
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    
    
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

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

@end
