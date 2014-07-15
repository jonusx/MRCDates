//
//  MRCDate.m
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import "MRCDate.h"

@interface MRCDate ()
@property (nonatomic, strong) NSMutableArray *elementHolderArray;
@property (nonatomic, assign, readwrite) NSUInteger numberOfElements;
@property (nonatomic, strong, readwrite) NSString *nameFull;
@end

@implementation MRCDate

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    _dateRange = [MRCDateRange dateRangeAroundDate:date forUnitRange:[self calendarUnit]];
    return self;
}

- (instancetype)initWithDateRange:(MRCDateRange *)dateRange {
    self = [super init];
    _dateRange = dateRange;
    return self;
}

- (instancetype)initWithElements:(id)elementsArray {
    if ([elementsArray count] == 0) {
        self = nil;
        return self;
    }
    
    if (![elementsArray[0] isKindOfClass:[self calendarSubUnitClass]]) {
        NSException *badSubelementException = [NSException exceptionWithName:@"Invalid data" reason:@"Provided subelements are not subelements of this class." userInfo:@{@"Expected subelement class" : NSStringFromClass([self calendarSubUnitClass]), @"Elements" : elementsArray}];
        [badSubelementException raise];
        return nil;
    }
    
    self = [super init];
    NSDate *startDate;
    if ([elementsArray[0] isKindOfClass:[NSDate class]]) {
        startDate = elementsArray[0];
    }
    else
    {
        startDate = ((MRCDate *)elementsArray[0]).dateRange.startDate;
    }
    _dateRange = [MRCDateRange dateRangeAroundDate:startDate forUnitRange:[self calendarUnit]];
    
    if ([elementsArray count] != self.numberOfElements) {
        NSException *badSubelementException = [NSException exceptionWithName:@"Invalid data" reason:@"Provided subelements do not match required amount of subelements." userInfo:@{@"Expected" : @(self.numberOfElements), @"Provided" : @([elementsArray count])}];
        [badSubelementException raise];
        self = nil;
        return nil;
    }
    _elementHolderArray = elementsArray;
    
    return self;
}

- (BOOL)containsDate:(NSDate *)date {
    NSComparisonResult startCompare = [date compare:_dateRange.startDate];
    NSComparisonResult endCompare = [date compare:_dateRange.endDate];
    if ((startCompare == NSOrderedSame || startCompare == NSOrderedDescending) && (endCompare == NSOrderedSame || endCompare == NSOrderedAscending)) {
        return YES;
    }
    return NO;
}

- (NSString *)nameFull {
    if (_nameFull) {
        return _nameFull;
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self calendarUnit]|NSCalendarUnitWeekday fromDate:_dateRange.startDate];
    NSInteger unit = [[components valueForKeyPath:[self componentsKeyPath]] integerValue];
    _nameFull = [self nameSymbols][unit - 1];
    return _nameFull;
}

- (NSUInteger)numberOfElements {
    if (_numberOfElements) {
        return _numberOfElements;
    }
    _numberOfElements = [[NSCalendar currentCalendar] rangeOfUnit:[self calendarSubUnit] inUnit:[self calendarUnit] forDate:self.dateRange.startDate].length;
    return _numberOfElements;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    NSInteger days = 0;
    NSCalendar *current;
    NSDateComponents *components;
    if (state->state == 0)
    {
        current = [NSCalendar currentCalendar];
        state->mutationsPtr = &state->extra[0];
        components = [current components:[self calendarSubUnit] fromDate:self.dateRange.startDate toDate:self.dateRange.endDate options:0];
        days = [self numberOfElements];
        state->extra[0] = days;
        state->extra[1] = (uintptr_t)current;
        state->extra[2] = (uintptr_t)components;
    }
    else
    {
        days = state->extra[0];
        current = (__bridge NSCalendar *)(void *)(state->extra[1]);
        components = (__bridge NSDateComponents *)(void *)(state->extra[2]);
    }
    NSUInteger count = 0;
    if (state->state <= days) {
        state->itemsPtr = buffer;
        while (state->state < days && count < len) {
            [components setValue:@(state->state) forKeyPath:[self subComponentsKeyPath]];
            NSDate *date = [current dateByAddingComponents:components toDate:self.dateRange.startDate options:0];
            buffer[count] = [self subelementForNumber:[[components valueForKeyPath:[self subComponentsKeyPath]] integerValue] date:date];
            state->state++;
            count++;
        }
    }
    return count;
}

- (NSMutableArray *)elementHolderArray {
    if (_elementHolderArray) {
        return _elementHolderArray;
    }
    _elementHolderArray = [NSMutableArray new];
    for (NSInteger index = 0; index < self.numberOfElements; index++) {
        _elementHolderArray[index] = [NSNull null];
    }
    return _elementHolderArray;
}

- (id)subelementForNumber:(NSInteger)elementNumber date:(NSDate *)date {
    id day = self.elementHolderArray[elementNumber];
    if (day == [NSNull null]) {
        Class subElementClass = [self calendarSubUnitClass];
        if (subElementClass) {
            if (!date || subElementClass == [NSDate class]) {
                NSDateComponents *components = [NSDateComponents new];
                [components setValue:@(elementNumber) forKeyPath:[self subComponentsKeyPath]];
                date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.dateRange.startDate options:0];
            }
            
            if (subElementClass == [NSDate class]) {
                day = date;
            }
            else
            {
                day = [(MRCDate *)[subElementClass alloc] initWithDate:date];
            }
        }
        else
        {
            day = date;
        }
        self.elementHolderArray[elementNumber] = day;
    }
    return day;
}

- (void)clearCache {
    [self.elementHolderArray removeAllObjects];
    self.elementHolderArray = nil;
    _numberOfElements = 0;
}


@end
