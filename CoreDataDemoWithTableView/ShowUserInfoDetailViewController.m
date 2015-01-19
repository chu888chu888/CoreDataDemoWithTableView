//
//  ShowUserInfoDetailViewController.m
//  CoreDataDemoWithTableView
//
//  Created by chuguangming on 15/1/14.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "ShowUserInfoDetailViewController.h"

@interface ShowUserInfoDetailViewController ()

@end

@implementation ShowUserInfoDetailViewController
@synthesize username,age;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"传递过来的username:%@",self.username);
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

@end
