//
//  BrowseViewController.h
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblEmp;

@end
