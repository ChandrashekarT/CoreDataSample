//
//  Empolyees.h
//  CoreDataSampleTest8
//
//  Created by ShivKumar G on 28/08/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Empolyees : NSManagedObject

@property (nonatomic, retain) NSNumber * empId;
@property (nonatomic, retain) NSString * empName;
@property (nonatomic, retain) NSString * empSpecialization;
@property (nonatomic, retain) NSString * empExperience;

@end
