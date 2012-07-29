//
//  STViewController.m
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "STViewController.h"
#import "STDataStore.h"
#import "STEntry.h"
#import "NSManagedObject+STAdditions.h"
#import "STEntry+STViewControllerAdditions.h"


@interface STViewController ()
@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly, strong) NSFetchedResultsController *fetchedResultsController;
@end


@implementation STViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id) initWithCoder:(NSCoder *)aDecoder {

	self = [super initWithCoder:aDecoder];
	
	NSManagedObjectContext *ctx = self.managedObjectContext;
	NSDate *currentDate = [NSDate date];
	for (NSTimeInterval timeInterval = 0; timeInterval < (86400 + 43200); timeInterval += 3600) {

		STEntry *pastEntry = [STEntry newObjectInContext:ctx];
		pastEntry.date = [currentDate dateByAddingTimeInterval:(-1 * timeInterval)];
		
		STEntry *futureEntry = [STEntry newObjectInContext:ctx];
		futureEntry.date = [currentDate dateByAddingTimeInterval:timeInterval];
	
	}

	return self;

}

- (NSManagedObjectContext *) managedObjectContext {

	if (!_managedObjectContext) {
	
		STDataStore * const ds = [STDataStore defaultStore];
		_managedObjectContext = [ds newContextWithConcurrencyType:NSMainQueueConcurrencyType];
	
	}
	
	return _managedObjectContext;

}

- (NSFetchedResultsController *) fetchedResultsController {

	if (!_fetchedResultsController) {

		NSManagedObjectContext * const moc = self.managedObjectContext;
		NSPersistentStoreCoordinator * const psc = moc.persistentStoreCoordinator;
		NSManagedObjectModel * const model = psc.managedObjectModel;
		
		NSFetchRequest * const fetchRequest = (NSFetchRequest *)[STEntry newFetchRequestInModel:model];
		NSString * const sectionNameKeyPath = @"presentationSectionHeader";
		NSString * const cacheName = nil;
		
		if (sectionNameKeyPath) {
		
			NSSortDescriptor *sectionSD = [NSSortDescriptor sortDescriptorWithKey:sectionNameKeyPath ascending:YES];
			fetchRequest.sortDescriptors = [[NSArray arrayWithObject:sectionSD] arrayByAddingObjectsFromArray:fetchRequest.sortDescriptors];
			
		}
		
		_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
		
		[_fetchedResultsController performFetch:nil];
	
	}
	
	return _fetchedResultsController;

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	NSFetchedResultsController * const frc = self.fetchedResultsController;
	id<NSFetchedResultsSectionInfo> const sectionInfo = [frc.sections objectAtIndex:section];
	
	return [sectionInfo numberOfObjects];

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

	NSFetchedResultsController * const frc = self.fetchedResultsController;
	return [frc.sections count];

}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	NSFetchedResultsController * const frc = self.fetchedResultsController;
	id<NSFetchedResultsSectionInfo> const sectionInfo = [frc.sections objectAtIndex:section];
	
	return [STEntry replacementSectionHeaderForString:sectionInfo.name];

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString * const reuseIdentifier = @"Cell";
	static UITableViewCellStyle const style = UITableViewCellStyleDefault;
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	NSCParameterAssert(cell);
	
	NSFetchedResultsController * const frc = self.fetchedResultsController;
	STEntry * const entry = (STEntry *)[frc objectAtIndexPath:indexPath];
	
	cell.textLabel.text = [NSDateFormatter localizedStringFromDate:entry.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
	
	return cell;

}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	
}

@end
