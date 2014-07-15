//
//  MRCDate.h
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCDateRange.h"

@protocol MRCDate <NSObject>
@optional
- (NSCalendarUnit)calendarUnit;
- (NSCalendarUnit)calendarSubUnit;
- (Class)calendarSubUnitClass;

//To support enumeration
- (NSString *)componentsKeyPath;
- (NSString *)subComponentsKeyPath;
- (NSArray *)nameSymbols;
@end

@interface MRCDate : NSObject <MRCDate, NSFastEnumeration>

@property (nonatomic, strong) MRCDateRange *dateRange;
@property (nonatomic, strong, readonly) NSString *nameFull;
@property (nonatomic, assign, readonly) NSUInteger numberOfElements;

- (instancetype)initWithDate:(NSDate *)date;
- (instancetype)initWithElements:(id)elementsArray;

- (id)subelementForNumber:(NSInteger)elementNumber date:(NSDate *)date;
- (void)clearCache;
- (BOOL)containsDate:(NSDate *)date;

@end
