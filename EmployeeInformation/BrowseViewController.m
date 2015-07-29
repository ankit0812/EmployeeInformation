//
//  BrowseViewController.m
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "BrowseViewController.h"
#import "DBManager.h"
#import "DetailViewController.h"

@interface BrowseViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrEmpInfo;      //Stores the entire info from the database


-(void)loadData;

@end

@implementation BrowseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tblEmp.delegate = self;
    self.tblEmp.dataSource = self;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"empdb.sqlite"];
    
    [self loadData];
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

-(void)loadData
{
    // Form the query.
    NSString *query = @"select * from empInfo order by empID";
    
    // Get the results.
    if (self.arrEmpInfo != nil)
    {
        self.arrEmpInfo = nil;
    }
    self.arrEmpInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblEmp reloadData];
}


// No. of sections in table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Number of Rows in Section

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrEmpInfo.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

//Deque the cell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfEmpId = [self.dbManager.arrColumnNames indexOfObject:@"empID"];
    NSInteger indexOfFirstName = [self.dbManager.arrColumnNames indexOfObject:@"firstName"];
    NSInteger indexOfLastName = [self.dbManager.arrColumnNames indexOfObject:@"lastName"];
    
   // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstName],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLastName]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"EmpID: %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfEmpId]];
    
    return cell;
}

//Passing the value to Detail View Controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailView"])
    {
        
        NSInteger indexOfFirstName = [self.dbManager.arrColumnNames indexOfObject:@"firstName"];
        NSInteger indexOfLastName = [self.dbManager.arrColumnNames indexOfObject:@"lastName"];
        NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
        NSInteger indexOfDesignation = [self.dbManager.arrColumnNames indexOfObject:@"designation"];
        NSInteger indexOfDepartment = [self.dbManager.arrColumnNames indexOfObject:@"department"];
        NSInteger indexOfImage = [self.dbManager.arrColumnNames indexOfObject:@"image"];
        NSInteger indexOfTagLine = [self.dbManager.arrColumnNames indexOfObject:@"tagLine"];
        
        
        NSIndexPath *indexPath = [self.tblEmp indexPathForSelectedRow];
        
        DetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.actualFirstName  = [NSString stringWithFormat:@"First Name : %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstName]];
        destViewController.actualLastName  = [NSString stringWithFormat:@"Last Name : %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLastName]];
        destViewController.actualAge  = [NSString stringWithFormat:@"Age : %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
        destViewController.actualDesignation  = [NSString stringWithFormat:@"Designation: %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDesignation]];
        destViewController.actualDepartment  = [NSString stringWithFormat:@"Department : %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDepartment]];
        destViewController.actualImageView  = [NSString stringWithFormat:@"%@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfImage]];
        destViewController.actualTagLine  = [NSString stringWithFormat:@"Tagline: %@", [[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfTagLine]];
        
        
        //To check output on console
        NSLog(@"%@",destViewController.actualImageView );
        
    }
}


@end
