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

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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


- (IBAction)searchButton:(id)sender
{
    [self performSegueWithIdentifier:@"query" sender:self];
    
    sqlite3_stmt *statement;
    NSString *query = [NSString stringWithFormat:@"SELECT  FROM emp WHERE name = %d",[self.empidValue.text intValue]];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        if (self.dbManager.affectedRows != 0)
        {
            
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
            
            
            
            // Pop the view controller.
          //  [self.navigationController popViewControllerAnimated:YES];
            
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


             
     

        [self performSegueWithIdentifier:@"search" sender:self];
    }
 
}
*/

@end
