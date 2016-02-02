//
//  EmployeeViewController.m
//  CoreDataSampleTest8
//
//  Created by ShivKumar G on 28/08/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController ()

@end

@implementation EmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication]delegate];
    if (appDelegate.isNewEmployee == YES) {
        [saveBut setTitle:@"Save" forState:UIControlStateNormal];
    }
    else
    {
        empIdTxt.text=_idStr;
        empNameTxt.text=_nameStr;
        empSpecialityTxt.text=_specialityStr;
        empExperienceTxt.text=_experienceStr;
        
        [saveBut setTitle:@"Update" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveOrUpdateDate:(id)sender
{
    NSError *error;
    NSManagedObjectContext *context=[appDelegate managedObjectContext];
    
    NSFetchRequest *fetchReq=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Employees" inManagedObjectContext:context];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empId == %@",_idStr];
    [fetchReq setEntity:entity];
    [fetchReq setPredicate:predicate];
    
    Empolyees *existedEmp=[[context executeFetchRequest:fetchReq error:&error] lastObject];
    
    if (!existedEmp) {
        Empolyees *newEmp=[NSEntityDescription insertNewObjectForEntityForName:@"Employees" inManagedObjectContext:context];
        //newEmp.empId=[NSNumber numberWithInt:(int)empIdTxt.text];
        newEmp.empId=[NSNumber numberWithInt:empIdTxt.text.intValue];
        newEmp.empName=empNameTxt.text;
        newEmp.empSpecialization=empSpecialityTxt.text;
        newEmp.empExperience=empExperienceTxt.text;
    }
    else
    {
        existedEmp.empId=[NSNumber numberWithInt:empIdTxt.text.intValue];
        existedEmp.empName=empNameTxt.text;
        existedEmp.empSpecialization=empSpecialityTxt.text;
        existedEmp.empExperience=empExperienceTxt.text;
    }
    
    if (![context save:&error]) {
        NSLog(@"Data Save or Update Error : %@",error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
