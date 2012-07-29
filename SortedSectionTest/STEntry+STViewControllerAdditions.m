//
//  STEntry+STViewControllerAdditions.m
//  SortedSectionTest
//
//  Created by Evadne Wu on 7/30/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "STEntry+STViewControllerAdditions.h"

@implementation STEntry (STViewControllerAdditions)

+ (NSArray *) sectionHeaders {

	static dispatch_once_t onceToken;
	static NSArray *sectionHeaders = nil;
	dispatch_once(&onceToken, ^{
		
		sectionHeaders = [NSArray arrayWithObjects:
			
			@"After Today",
			@"Today",
			@"Before Today",
			
		nil];
		
	});
	
	return sectionHeaders;

}

+ (NSString *) replacementSectionHeaderForString:(NSString *)string {

	NSArray *sectionHeaders = [self sectionHeaders];
	NSUInteger index = [string integerValue];
	
	return [sectionHeaders objectAtIndex:index];

}

- (NSString *) presentationSectionHeader {

	NSArray *allSectionHeaders = [[self class] sectionHeaders];
	NSString *sectionHeader = [self sectionHeader];
	NSUInteger index = [allSectionHeaders indexOfObject:sectionHeader];
	
	NSCParameterAssert(index != NSNotFound);
	
	return [NSString stringWithFormat:@"%i", index];

}

- (NSString *) sectionHeader {

	NSCalendar * const calendar = [NSCalendar currentCalendar];
	NSUInteger const dateComponents = NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
	
	NSDate *nowDate = [NSDate date];
	NSDateComponents *nowDateComponents = [calendar components:dateComponents fromDate:nowDate];
	
	NSDate *todayDate = [calendar dateFromComponents:nowDateComponents];
	
	NSDateComponents *selfComponents = [calendar components:dateComponents fromDate:self.date];
	NSDate *selfDate = [calendar dateFromComponents:selfComponents];

	switch ([todayDate compare:selfDate]) {
	
		case NSOrderedDescending:
			return @"Before Today";
			
		case NSOrderedSame:
			return @"Today";
		
		case NSOrderedAscending:
			return @"After Today";
	
	}
	
	return nil;
	
}

@end
