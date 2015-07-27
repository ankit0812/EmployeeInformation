//
//  BrowseViewController.m
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "BrowseViewController.h"
#import "DBManager.h"



@interface BrowseViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrEmpInfo;


-(void)loadData;

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tblEmp.delegate = self;
    self.tblEmp.dataSource = self;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"empdb.sqlite"];
    
    [self loadData];
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
*/

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from empInfo";
    
    // Get the results.
    if (self.arrEmpInfo != nil) {
        self.arrEmpInfo = nil;
    }
    self.arrEmpInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblEmp reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrEmpInfo.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfEmpId = [self.dbManager.arrColumnNames indexOfObject:@"empID"];
    NSInteger indexOfFirstName = [self.dbManager.arrColumnNames indexOfObject:@"firstName"];
    NSInteger indexOfLastName = [self.dbManager.arrColumnNames indexOfObject:@"lastName"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    NSInteger indexOfDesignation = [self.dbManager.arrColumnNames indexOfObject:@"designation"];
    NSInteger indexOfDepartment = [self.dbManager.arrColumnNames indexOfObject:@"department"];
    NSInteger indexOfImage = [self.dbManager.arrColumnNames indexOfObject:@"image"];
    NSInteger indexOfTagLine = [self.dbManager.arrColumnNames indexOfObject:@"tagLine"];
    
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@",[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfEmpId],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstName],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLastName],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDesignation],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDepartment],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfImage],[[self.arrEmpInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfTagLine]];
    
    
    return cell;
}

-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EditInfoViewController *editInfoViewController = [segue destinationViewController];
    editInfoViewController.delegate = self;
}

@end
