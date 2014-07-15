//
//  MRCDate.h
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
#import "MRCDateRange.h"

/**
 `MRCDate` is a protocol that can be extended to objects wishing to be treated as date objects.
 */

@protocol MRCDate <NSObject>
@optional
/**
 The calendar unit the object wishes to be treated as should be returned here.
 
 @return The specific calendar unit this object corresponds to.
 */
- (NSCalendarUnit)calendarUnit;

/**
 The calendar unit the object may be broken up into should be returned here.
 
 @return The subunit calendar unit this object breaks up into. I.e. Weeks -> Days
 */
- (NSCalendarUnit)calendarSubUnit;

/**
 The custom class the subunit should use.
 
 @return A custom date class. If nil, defaults to `NSDate`
 */
- (Class)calendarSubUnitClass;

//To support enumeration

/**
 The `NSDateComponents` keypath to use for this object.
 
 @return A keypath corresponding to a keypath for `NSDateComponents`
 */
- (NSString *)componentsKeyPath;

/**
 The `NSDateComponents` keypath to use for this objects subunits.
 
 @return A keypath corresponding to a keypath for `NSDateComponents`
 */
- (NSString *)subComponentsKeyPath;

/**
 An `NSArray` of `NSStrings` that will be used for named elements.
 
 @return An `NSArray` of `NSString` objects
 */
- (NSArray *)nameSymbols;

@end

/**
 `MRCDate` is a root subclass for date objects
 */
@interface MRCDate : NSObject <MRCDate, NSFastEnumeration>

/**
 Date range that represents this date.
 */
@property (nonatomic, strong) MRCDateRange *dateRange;

/**
 Name of this specific date object
 */
@property (nonatomic, strong, readonly) NSString *nameFull;

/**
 The amount of subelements in this date
 */
@property (nonatomic, assign, readonly) NSUInteger numberOfElements;

/**
 Designated initializer
 
 @param date `NSDate` object used to create this object
 
 @return Initialized `MRCDate` object with `MRCDateRange` built from input param.
 */
- (instancetype)initWithDate:(NSDate *)date;

/**
 @param elementsArray `NSArray` object with appropriate sub-date objects to constuct the `MRCDate` object
 
 @return Initialized `MRCDate` object with pre-populated subelements.
 */
- (instancetype)initWithElements:(NSArray *)elementsArray;

/**
 @param elementNumber The index of the subelement.
 @param date The date to use for the subelement if needed. If nil, date is inferred by elementNumber and startDate
 
 @return Initialized `MRCDate` subclass using returned class from calendarSubUnitClass.
 */
- (id)subelementForNumber:(NSInteger)elementNumber date:(NSDate *)date;

/**
 Clears internal subelement cache
 */
- (void)clearCache;

/**
 @param date `NSDate` to check
 
 @return BOOL if date is within this objects dateRange
 */
- (BOOL)containsDate:(NSDate *)date;

@end
