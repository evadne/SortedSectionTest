//
//  STEntry+STAdditions.m
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "STEntry+STAdditions.h"
#import "NSManagedObject+STAdditions.h"

@implementation STEntry (STAdditions)

+ (NSFetchRequest *) newFetchRequestInModel:(NSManagedObjectModel *)model {

	NSFetchRequest *fr = [super newFetchRequestInModel:model];
	fr.sortDescriptors = [NSArray arrayWithObjects:
		[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES],
	nil];
	
	return fr;

}

@end
