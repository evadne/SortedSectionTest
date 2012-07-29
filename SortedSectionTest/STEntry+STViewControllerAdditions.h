//
//  STEntry+STViewControllerAdditions.h
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "STEntry.h"

@interface STEntry (STViewControllerAdditions)

+ (NSArray *) sectionHeaders;
+ (NSString *) replacementSectionHeaderForString:(NSString *)string;

@property (nonatomic, readonly, strong) NSString *presentationSectionHeader;
@property (nonatomic, readonly, strong) NSString *sectionHeader;

@end
