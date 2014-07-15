MRCDates
========

MRCDate and MRCDateRange is a more flexible way to deal with dates. Very rarely are we ever dealing with concrete, pinpoint dates. 

Usage
-----

To build a MRCMonth:

```objective-c
  MRCMonth *march = [[MRCMonth alloc] initWithMonth:3];
```

To build a MRCMonth for the current month:

```objective-c
  MRCMonth *month = [[MRCMonth alloc] initWithDate:[NSDate date]];
```

Iterate through all days in a month

```objective-c
  for (MRCDay *day in month) {
    NSLog(@"%@", [day weekDayNameShort]);
  }
```

* MRCYear iterates through its MRCMonth objects
* MRCMonth iterates through its MRCDay objects
* MRCWeek iterates through its MRCDay objects
* MRCDay iterates through its NSDates for each hour of the day


Overall, it should be pretty easy to use.

Contributing
------------

Feel free to fork and send me pull requests
