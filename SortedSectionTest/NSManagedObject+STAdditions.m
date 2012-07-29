//
//  NSManagedObject+STAdditions.m
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "NSManagedObject+STAdditions.h"

@implementation NSManagedObject (STAdditions)

+ (NSEntityDescription *) entityDescriptionInModel:(NSManagedObjectModel *)model {

	for (NSEntityDescription *entity in model.entities) {
		Class entityClass = NSClassFromString(entity.managedObjectClassName);
		if ((self == entityClass) || [self isSubclassOfClass:entityClass]) {
			return entity;
		}
	}
	
	return nil;

}

+ (id) newObjectInContext:(NSManagedObjectContext *)context {

	NSEntityDescription *entity = [self entityDescriptionInModel:context.persistentStoreCoordinator.managedObjectModel];
	
	return [[self alloc] initWithEntity:entity insertIntoManagedObjectContext:context];

}

+ (NSFetchRequest *) newFetchRequestInModel:(NSManagedObjectModel *)model {

	NSEntityDescription * const entity = [self entityDescriptionInModel:model];
	NSFetchRequest * const fr = [NSFetchRequest fetchRequestWithEntityName:entity.name];
	
	return fr;
	
}

@end
