//
//  STDataStore.m
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "STDataStore.h"


@interface STDataStore ()
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly, strong) NSManagedObjectModel *managedObjectModel;
@end


@implementation STDataStore
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;

+ (id) defaultStore {

	static dispatch_once_t onceToken;
	static STDataStore *store = nil;
	dispatch_once(&onceToken, ^{
    store = [self new];
	});
	
	return store;

}

- (id) init {

	self = [super init];
	if (!self)
		return nil;
	
	return self;

}

- (NSManagedObjectContext *) newContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type {

	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	context.persistentStoreCoordinator = self.persistentStoreCoordinator;
	
	return context;

}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

	if (!_persistentStoreCoordinator) {
	
		_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
		
		//	Not adding stores yet
	
	}
	
	return _persistentStoreCoordinator;

}

- (NSManagedObjectModel *) managedObjectModel {

	if (!_managedObjectModel) {
	
		NSURL *url = [[NSBundle mainBundle] URLForResource:@"STModel" withExtension:@"momd"];
	
		_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
	
	}
	
	return _managedObjectModel;

}

@end
