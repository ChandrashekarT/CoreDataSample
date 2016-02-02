//
//  EmployeeViewController.h
//  CoreDataSampleTest8
//
//  Created by ShivKumar G on 28/08/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Empolyees.h"

@interface EmployeeViewController : UIViewController
{
    IBOutlet UITextField *empIdTxt;
    IBOutlet UITextField *empNameTxt;
    IBOutlet UITextField *empSpecialityTxt;
    IBOutlet UITextField *empExperienceTxt;
    
    IBOutlet UIButton *saveBut;
    
    AppDelegate *appDelegate;
}

@property (strong,nonatomic) NSString *idStr;
@property (strong,nonatomic) NSString *nameStr;
@property (strong,nonatomic) NSString *specialityStr;
@property (strong,nonatomic) NSString *experienceStr;

-(IBAction)saveOrUpdateDate:(id)sender;

@end
