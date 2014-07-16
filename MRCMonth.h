//
//  MRCMonth.h
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <Foundation/Foundation.h>
#import "MRCDate.h"

@class MRCDay, MRCWeek;

/**
 `MRCMonth` Represents a 'month' for the current calendar.
 */
@interface MRCMonth : MRCDate

/**
 Number of weeks in this month
 */
@property (nonatomic, assign, readonly) NSUInteger numberOfWeeks;

/**
 When set to yes, the month will include a full week (7 days gregorian) for each week, including days that aren't in the 
 current month. The first week will be prefixed with the last months days as the last week will be suffixed with 
 the first days in the next month.
 */
@property (nonatomic, assign, getter = isUsingBlockDates) BOOL useBlockDates;

/**
 Number of the month for use in calendar calculations
 */
@property (nonatomic, assign, readonly) NSUInteger monthNumber;

/**
 Designated initializer
 
 @param month The month number used in calendar components. 1 == January, so on
 
 @return Initialized `MRCMonth` for month number in current year.
 */
- (instancetype)initWithMonth:(NSInteger)month;

/**
 @param month The month number used in calendar components. 1 == January, so on
 @param year The year Ex: 2005
 
 @return Initialized `MRCMonth` for month number in given year.
 */
- (instancetype)initWithMonth:(NSInteger)month year:(NSInteger)year;

/**
 @param date `NSDate` to build the month around
 
 @return Initialized `MRCMonth`.
 */
- (instancetype)initWithDate:(NSDate *)date;

/**
 @param weekNumber The week number used in calendar components. Uses the months cached subelement `MRCDay` objects to construct the `MRCWeek`
 
 @return Initialized `MRCWeek`.
 */
- (MRCWeek *)week:(NSInteger)weekNumber;

@end
