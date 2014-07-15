//
//  MRCDateRange.h
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

/**
 `MRCDateRange` Is a basic range using two dates
 */
@interface MRCDateRange : NSObject

@property (nonatomic, strong, readonly) NSDate *startDate;
@property (nonatomic, strong, readonly) NSDate *endDate;

/**
 Designated initializer
 
 @param startDate `NSDate` object to use for the start of the date range.
 @param endDate `NSDate` object to use for the end of the date range.
 
 @return Initialized `MRCDateRange` object.
 */
- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/**
 Convenience initializer, calls initWithStartDate:endDate:
 
 @param startDate `NSDate` object to use for the start of the date range.
 @param endDate `NSDate` object to use for the end of the date range.
 
 @return Initialized `MRCDateRange` object.
 */
+ (instancetype)dateRangeWithStartBeginningDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/**
 Convenience initializer, builds date range with todays date for given `NSCalendarUnit`
 Ex: Given `NSCalendarUnitWeekOfMonth`, this will return a date range for the week that today is contained in
 
 @param calendarUnitRange `NSCalendarUnit` to construct around todays date
 
 @return Initialized `MRCDateRange` object.
 */
+ (instancetype)dateRangeWithTodayForUnitRange:(NSCalendarUnit)calendarUnitRange;

/**
 Convenience initializer, builds date range with todays date for given `NSCalendarUnit`
 
 @param date `NSDate` to construct date range in
 @param calendarUnitRange `NSCalendarUnit` to construct with
 
 @return Initialized `MRCDateRange` object.
 */
+ (instancetype)dateRangeAroundDate:(NSDate *)date forUnitRange:(NSCalendarUnit)calendarUnitRange;

/**
 Convenience method returning the start date for an `NSCalendarUnit`
 Ex: Given `NSCalendarUnitWeekOfMonth`, returns the start of the week for the provided date
 
 @param unit `NSCalendarUnit` for the start date
 @param date `NSDate` to use to find the appropriate start date
 
 @return An `NSDate` object for the starting date for the givin information
 */
+ (NSDate *)startDateForUnit:(NSCalendarUnit)unit date:(NSDate *)date;

@end
