//
//  SearchViewController.m
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/28/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "SearchViewController.h"
#import "DBManager.h"
#import "DetailViewController.h"
#import <sqlite3.h>

@interface SearchViewController ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic,strong ) NSArray *results;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"empdb.sqlite"];
    
    self.empidValue.delegate = self;
    self.nameValue.delegate = self;
    self.designationValue.delegate = self;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
//    [self loadData];

}

-(void)viewDidUnload
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


//For Search with EMPID
-(void)loadData :(NSString*)empID
{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select * from empInfo where empID=%d", [empID intValue]];
    // Get the results.
    if (self.results != nil)
    {
        self.results = nil;
    }
    self.results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
}


// For search with Name and Designation
-(void)loadData2 :(NSString*)name data2:(NSString *)design
{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select * from empInfo where firstName='%@' AND designation='%@'",name,design];
    // Get the results.
    if (self.results != nil)
    {
        self.results = nil;
    }
    self.results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
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
}*/

- (IBAction)searchNameDes:(id)sender
{
    
    [self loadData2:self.nameValue.text data2:self.designationValue.text];
    
    if(_results.count==0)
    {
        NSString *error;
        
        error = [NSString stringWithFormat:@"%@\n%@",
                 @"No Such Entry",
                 @"Try Again"];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:error
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
    [self performSegueWithIdentifier:@"searchName" sender:self];
    }
}

- (IBAction)searchButton:(id)sender
{
    
   [self loadData:self.empidValue.text];
    
   if(_results.count==0)
   {
       NSString *error;
       
       error = [NSString stringWithFormat:@"%@\n%@",
                @"No Such Entry",
                @"Try Again"];
       
       UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:error
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
       [message show];
   }
   else
   {
   [self performSegueWithIdentifier:@"query" sender:self];
   }
}



// Set the loaded data to the textfields.
    
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        
    if ([segue.identifier isEqualToString:@"query"])
    {
    DetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.actualFirstName  = [NSString stringWithFormat:@"First Name : %@ \n",[[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstName"]]];
                                           
    destViewController.actualLastName = [NSString stringWithFormat:@"Last Name : %@ \n",[[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastName"]] ];
    destViewController.actualAge = [NSString stringWithFormat:@"Age : %@ \n",[[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]]];
    destViewController.actualDesignation = [NSString stringWithFormat:@"Designation : %@ \n",[[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"designation"]] ];

    destViewController.actualDepartment = [NSString stringWithFormat:@"Department : %@ \n",[[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"department"]] ];
        
    destViewController.actualImageView  = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"image"]];

    destViewController.actualTagLine  = [NSString stringWithFormat:@"TagLine : %@ \n",[[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"tagLine"] ]];
        
         NSLog(@"%@",destViewController.actualImageView );
        
        
    }
    
    
    if ([segue.identifier isEqualToString:@"searchName"])
        
    {
        DetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.actualFirstName  = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstName"]];
        destViewController.actualLastName = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastName"]];
        destViewController.actualAge = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
        destViewController.actualDesignation = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"designation"]];
        
        destViewController.actualDepartment = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"department"]];
        
        destViewController.actualImageView  = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"image"]];
        
        destViewController.actualTagLine  = [[_results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"tagLine"]];
        
        NSLog(@"%@",destViewController.actualImageView );
        
       
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
    
    if (!CGRectContainsPoint(aRect, _empidValue.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _empidValue.frame.origin.y - (keyboardSize.height));
    }
    else if ( !CGRectContainsPoint(aRect, _nameValue.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _nameValue.frame.origin.y - (keyboardSize.height));
    }
    else if (  !CGRectContainsPoint(aRect, _designationValue.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _designationValue.frame.origin.y - (keyboardSize.height));
    }
 
    
    [_scroller setContentOffset:scrollPoint animated:YES];
    
    //_scroller.contentOffset = CGPointMake(0, [_scroller convertPoint:CGPointZero fromView:textField].y - 60);
    
    
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
}





@end
