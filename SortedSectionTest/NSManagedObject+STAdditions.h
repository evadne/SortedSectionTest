//
//  NSManagedObject+STAdditions.h
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (STAdditions)

+ (id) newObjectInContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *) newFetchRequestInModel:(NSManagedObjectModel *)model;

@end
