//
//  UserInfo.h
//  CoreDataDemoWithTableView
//
//  Created by chuguangming on 15/1/14.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * age;

@end
