//
//  STDataStore.h
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface STDataStore : NSObject

+ (id) defaultStore;

- (NSManagedObjectContext *) newContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type;

@end
