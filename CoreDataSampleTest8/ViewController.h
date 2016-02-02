//
//  ViewController.h
//  CoreDataSampleTest8
//
//  Created by ShivKumar G on 28/08/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "AppDelegate.h"
#import "Empolyees.h"
#import "EmployeeViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    
    NSArray *empDetailArr;
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSFetchRequest *fetchReq;
    NSEntityDescription *entity;
}


@end

