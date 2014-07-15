//
//  MRCDay.h
//
//  Created by mathew cruz on 6/18/14.
//  Copyright (c) 2014 Mathew Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCDate.h"

@interface MRCDay : MRCDate

@property (nonatomic, strong, readonly) NSString *weekDayNameShort;
@property (nonatomic, copy) NSDateComponents *components;

- (instancetype)initWithDate:(NSDate *)date;
- (BOOL)isInWeekend;

@end
