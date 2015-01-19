//
//  AddCoreDataViewController.m
//  CoreDataDemoWithTableView
//
//  Created by chuguangming on 15/1/14.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "AddCoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "UserInfo.h"
#import "AppDelegate.h"
@interface AddCoreDataViewController ()

@end

@implementation AddCoreDataViewController
@synthesize lblUserAge,lblUserName,lblUserPhone;
@synthesize txtUserAge,txtUserName,txtUserPhone;
@synthesize btnAdd;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lblUserName=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 50)];
    lblUserName.text=@"UserName:";
    lblUserName.textAlignment=UITextAlignmentRight;
    lblUserName.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:lblUserName];
    
    lblUserAge=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, 100, 50)];
    lblUserAge.text=@"UserAge:";
    lblUserAge.textAlignment=UITextAlignmentRight;
    lblUserAge.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:lblUserAge];
    
    lblUserPhone=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 50)];
    lblUserPhone.text=@"UserPhone:";
    lblUserPhone.textAlignment=UITextAlignmentRight;
    lblUserPhone.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:lblUserPhone];
    
    txtUserName=[[UITextField alloc] initWithFrame:CGRectMake(100, 65, 200, 35)];
    [txtUserName setBorderStyle:UITextBorderStyleRoundedRect];
    txtUserName.returnKeyType = UIReturnKeyDone;
    txtUserName.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview:txtUserName];
    
    txtUserAge=[[UITextField alloc] initWithFrame:CGRectMake(100, 115, 200, 35)];
    [txtUserAge setBorderStyle:UITextBorderStyleRoundedRect];
    txtUserAge.returnKeyType = UIReturnKeyDone;
    txtUserAge.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview:txtUserAge];
    
    txtUserPhone=[[UITextField alloc] initWithFrame:CGRectMake(100, 165, 200, 35)];
    [txtUserPhone setBorderStyle:UITextBorderStyleRoundedRect];
    txtUserPhone.returnKeyType = UIReturnKeyDone;
    txtUserPhone.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview:txtUserPhone];
    
    btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(0, 200, 100, 35);
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(AddAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
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
#pragma mark - 按钮添加事件
-(void)AddAction
{
    if ([self insertUserInfoWithName:txtUserName.text age:txtUserAge.text phone:txtUserPhone.text]) {
        NSLog(@"添加成功");
        [self dataFetchRequest];
    }
}
#pragma mark - 初始化数据
-(BOOL)insertUserInfoWithName:(NSString *)name age:(NSString *)age phone:(NSString*)phone
{
    
    if (!name||!age||!phone) {
        return NO;
    }
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    UserInfo  *userInfoObject = [self getUserInfoByName:name];
    if (nil == userInfoObject) {
        userInfoObject = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context];
    }
    userInfoObject.username = name;
    userInfoObject.age=age;
    userInfoObject.phone=phone;
    [appDelegate saveContext];
    return YES;
}
-(UserInfo *)getUserInfoByName:(NSString *)name
{
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    UserInfo *userInfoObject=nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *UserInfoEntity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:UserInfoEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@", name];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = NULL;
    NSArray *array = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
    }
    
    if (array && [array count] > 0) {
        userInfoObject = [array objectAtIndex:0];
    }
    
    
    return userInfoObject;
}
- (void)dataFetchRequest
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"username:%@", [info valueForKey:@"username"]);
    }
}
@end
