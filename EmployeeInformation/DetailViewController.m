//
//  DetailViewController.m
//  EmployeeInformation
//
//  Created by optimusmac4 on 7/28/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (UIImage *)loadImage: (NSString *)name;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //Assigning values that where fetched
    
    
    _FirstName.text=_actualFirstName;
    _LastName.text=_actualLastName;
    _Age.text=_actualAge;
    _Designation.text=_actualDesignation;
    _Department.text=_actualDepartment;
    _TagLine.text=_actualTagLine;
    _imageView.image=[self loadImage:_actualImageView];
    
    _scroller.delegate=self;
    [_scroller setShowsHorizontalScrollIndicator:NO];
    
    
    
}
float oldX; // here or better in .h interface



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

-(UIImage *)loadImage: (NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithString:name] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0  ||  scrollView.contentOffset.x < 0 )
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}
@end
