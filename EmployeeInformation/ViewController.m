//
//  ViewController.m
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/27/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // location where database gets created and images get saved
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewRecord:(id)sender {
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

- (IBAction)browseRecord:(id)sender
{
    [self performSegueWithIdentifier:@"browse" sender:self];
}

- (IBAction)searchRecord:(id)sender
{
    [self performSegueWithIdentifier:@"search" sender:self];
}




@end

