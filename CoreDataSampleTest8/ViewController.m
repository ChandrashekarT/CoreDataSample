//
//  ViewController.m
//  CoreDataSampleTest8
//
//  Created by ShivKumar G on 28/08/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self createTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTable
{
    appDelegate=[[UIApplication sharedApplication]delegate];
    context=[appDelegate managedObjectContext];
    
    fetchReq=[[NSFetchRequest alloc]init];
    entity=[NSEntityDescription entityForName:@"Employees" inManagedObjectContext:context];
    [fetchReq setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects=[context executeFetchRequest:fetchReq error:&error];
    
    //Sorting Array
    NSSortDescriptor *sortDiscriptor=[[NSSortDescriptor alloc]initWithKey:@"empId" ascending:YES];
    NSArray *discriptors=[NSArray arrayWithObject:sortDiscriptor];
    empDetailArr=[fetchedObjects sortedArrayUsingDescriptors:discriptors];
    
    [myTableView reloadData];
}

#pragma mark -- UITableView Delegate and DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return empDetailArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    
    CustomCell *cell=(CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    Empolyees *employee=[empDetailArr objectAtIndex:indexPath.row];
    
    cell.empIdLbl.text=[NSString stringWithFormat:@"%@",employee.empId];
    cell.empNAmeLbl.text=employee.empName;
    cell.empSpecialityLbl.text=employee.empSpecialization;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Empolyees *emps = [empDetailArr objectAtIndex:indexPath.row];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empId == %@",emps.empId];
        [fetchReq setPredicate:predicate];
        
        NSError *fetchError;
        NSArray *fetchedProducts=[context executeFetchRequest:fetchReq error:&fetchError];
        
        for (NSManagedObject *employeeObject in fetchedProducts) {
            [context deleteObject:employeeObject];
        }
        
        [context save:&fetchError];
        
        [self createTable];
    }
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Empolyees *emps = [empDetailArr objectAtIndex:indexPath.row];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"empId == %@",emps.empId];
    [fetchReq setPredicate:predicate];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EmployeeViewController *evc=[storyboard instantiateViewControllerWithIdentifier:@"EmployeeViewController"];
    
    NSError *fetchError;
    NSArray *fetchedProducts=[context executeFetchRequest:fetchReq error:&fetchError];
    
    Empolyees *emp=[fetchedProducts objectAtIndex:0];
    evc.idStr=[NSString stringWithFormat:@"%@",emp.empId];
    evc.nameStr=emp.empName;
    evc.specialityStr=emp.empSpecialization;
    evc.experienceStr=emp.empExperience;
    
    appDelegate.isNewEmployee=NO;
    
    [self.navigationController pushViewController:evc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Empolyees *employee=[empDetailArr objectAtIndex:indexPath.row];
    
    [[[UIAlertView alloc]initWithTitle:@"CoreDataSample" message:[NSString stringWithFormat:@"%@",employee.empName] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}


#pragma mark -- Segue Method
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    appDelegate.isNewEmployee=YES;
}

@end
