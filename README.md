# SYNUtils

[![Build Status](https://api.travis-ci.org/Syntertainment/SYNUtils.png)](https://travis-ci.org/Syntertainment/SYNUtils)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Utility methods, polyfills, and operators to simplify common tasks in Swift.

## Installation

...

## Documentation

### Global Methods

#### Math

* [`lerp`](#lerp)

#### Threading

* [`runOnMainThread`](#runOnMainThread)
* [`runOnMainThreadIfNeeded`](#runOnMainThreadIfNeeded)
* [`runOnMainThreadIfNeededSync`](#runOnMainThreadIfNeededSync)
* [`runOnMainThreadAfterDelay`](#runOnMainThreadAfterDelay)
* [`runAsync`](#runAsync)
* [`runAsyncAfterDelay`](#runAsyncAfterDelay)

### Extensions

#### Array

* [`Array.compact`](#Array.compact)
* [`indexOf`](#Array_indexOf)
* [`each`](#Array_each)
* [`contains`](#Array_contains)
* [`some`](#Array_some)
* [`every`](#Array_every)
* [`chooseRandom`](#Array_chooseRandom)
* [`pop`](#Array_pop)
* [`shift`](#Array_shift)
* [`unshift`](#Array_unshift)
* [`fill`](#Array_fill)

#### CGPoint

Adds `+`, `-`, `*`, `/` operators for two points and point with scalar.

#### CGRect

* [`center`](#CGRect_center)
* [`aspectFill`](#CGRect_aspectFill)
* [`aspectFit`](#CGRect_aspectFit)

#### CGSize

* [`aspectFill`](#CGSize_aspectFill)
* [`aspectFit`](#CGSize_aspectFit)

Adds `+`, `-`, `*`, `/` operators for two sizes and size with scalar.

#### Dictionary

* [`Dictionary.sortByKeys`](#Dictionary.sortByKeys)
* [`map`](#Dictionary_map)

#### Double

* [`abs`](#abs)
* [`sqrt`](#sqrt)
* [`floor`](#floor)
* [`ceil`](#ceil)
* [`round`](#round)
* [`clamp`](#clamp)
* [`random`](#random)

#### NSData

* [`init(base64URLData)`](#NSData_initBase64URLData)
* [`base64URLEncode`](#NSData_base64URLEncode)
* [`toHexString`](#NSData_toHexString)

#### NSDate

* [`NSDate.currentTZOffset`](#NSDate.currentTZOffset)
* [`NSDate.currentTZOffsetMinutes`](#NSDate.currentTZOffsetMinutes)
* [`init(dateString)`](#NSDate_initDateString)
* [`toISOString`](#NSDate_toISOString)
* [`toRFC3339String`](#NSDate_toRFC3339String)
* [`unixTimestamp`](#NSDate_unixTimestamp)
* [`shortRelativeString`](#NSDate_shortRelativeString)
* [`midnight`](#NSDate_midnight)
* [`addSeconds`](#NSDate_addSeconds)
* [`addMinutes`](#NSDate_addMinutes)
* [`addHours`](#NSDate_addHours)
* [`addDays`](#NSDate_addDays)
* [`addWeeks`](#NSDate_addWeeks)
* [`addMonths`](#NSDate_addMonths)
* [`addYears`](#NSDate_addYears)
* [`isAfter`](#NSDate_isAfter)
* [`isBefore`](#NSDate_isBefore)
* [`year`](#NSDate_year)
* [`month`](#NSDate_month)
* [`weekOfMonth`](#NSDate_weekOfMonth)
* [`weekday`](#NSDate_weekday)
* [`days`](#NSDate_days)
* [`hours`](#NSDate_hours)
* [`minutes`](#NSDate_minutes)
* [`seconds`](#NSDate_seconds)

#### NSObject

* [`getAssociatedObject`](#NSObject_getAssociatedObject)
* [`setAssociatedObject`](#NSObject_setAssociatedObject)
* [`lazyAssociatedObject`](#NSObject_lazyAssociatedObject)

#### NSRegularExpression

* [`init(pattern)`](#NSRegularExpression_initPattern)
* [`exec`](#NSRegularExpression_exec)
* [`test`](#NSRegularExpression_test)

#### NSString

* [`startsWith`](#NSString_startsWith)
* [`endsWith`](#NSString_endsWith)
* [`contains`](#NSString_contains)
* [`match`](#NSString_match)
* [`replace`](#NSString_replace)
* [`split`](#NSString_split)
* [`substr`](#NSString_substr)
* [`trim`](#NSString_trim)
* [`uriEncoded`](#NSString_uriEncoded)
* [`md5Sum`](#NSString_md5Sum)
* [`rangeWithOffsets`](#NSString_rangeWithOffsets)
* [`toStringRange`](#NSString_toStringRange)
* [`fullNSRange`](#NSString_fullNSRange)
* [`length`](#NSString_length)
* [`utf8Length`](#NSString_utf8Length)
* [`utf16Length`](#NSString_utf16Length)
* [`isValidURL`](#NSString_isValidURL)
* [`isValidEmail`](#NSString_isValidEmail)

#### NSTimer

* [`schedule`](#NSTimer_schedule)

#### Range

* [`each`](#Range_each)
* [`map`](#Range_map)
* [`toArray`](#Range_toArray)

Adds `==` operator for `Range<ForwardIndexType>`.

#### UIColor / NSColor

* [`init(argb)`](#UIColor_initARGB)
* [`init(hexString)`](#UIColor_initHexString)
* [`argb`](#UIColor_argb)
* [`hexString`](#UIColor_hexString)

typealias to `NSColor` on non-iOS, missing `init(red, green, blue, alpha)` added.

#### UIImage / NSImage

* [`UIImage.imageWithFill`](#UIImage.imageWithFill)
* [`pixelSize`](#UIImage_pixelSize)

typealias to `NSImage` on non-iOS, missing `init(CGImage)` and `CGImage` added.


<a name="Array.compact" />
### Array.compact(array: [T?]) -> [T]

Convert an array of optional types to non-optional types by removing any
nil entries

__Arguments__

* `array` - Array of optional types
* `returns` A copy of the given array, typecasted with nil entries removed

__Example__

```
```

---------------------------------------

<a name="Array_indexOf" />
### Array#indexOf(item: Equatable) -> Int?

Return the index of the first array element equal to `item`.

__Arguments__

* `item` - The item to search for
* `returns` A zero-based index for the first matching element in the
array, otherwise nil

__Example__

```
```

---------------------------------------
