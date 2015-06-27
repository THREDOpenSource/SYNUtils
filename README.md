# SYNUtils

[![Build Status](https://api.travis-ci.org/Syntertainment/SYNUtils.png)](https://travis-ci.org/Syntertainment/SYNUtils)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Utility methods, polyfills, and operators to simplify common tasks in Swift.

## Installation

...

## Documentation

### Global Methods

* [`lerp`](#lerp)
* [`runOnMainThread`](#runOnMainThread)
* [`runOnMainThreadIfNeeded`](#runOnMainThreadIfNeeded)
* [`runOnMainThreadIfNeededSync`](#runOnMainThreadIfNeededSync)
* [`runOnMainThreadAfterDelay`](#runOnMainThreadAfterDelay)
* [`runAsync`](#runAsync)
* [`runAsyncAfterDelay`](#runAsyncAfterDelay)

### Array

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

### CGPoint

Adds `+`, `-`, `*`, `/` operators for two points and point with scalar.

### CGRect

* [`center`](#CGRect_center)
* [`aspectFill`](#CGRect_aspectFill)
* [`aspectFit`](#CGRect_aspectFit)

### CGSize

* [`aspectFill`](#CGSize_aspectFill)
* [`aspectFit`](#CGSize_aspectFit)

Adds `+`, `-`, `*`, `/` operators for two sizes and size with scalar.

### Dictionary

* [`Dictionary.sortByKeys`](#Dictionary.sortByKeys)
* [`map`](#Dictionary_map)

### Double

* [`abs`](#abs)
* [`sqrt`](#sqrt)
* [`floor`](#floor)
* [`ceil`](#ceil)
* [`round`](#round)
* [`clamp`](#clamp)
* [`random`](#random)

### NSData

* [`init(base64URLData)`](#NSData_initBase64URLData)
* [`base64URLEncode`](#NSData_base64URLEncode)
* [`toHexString`](#NSData_toHexString)

### NSDate

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

Adds `+`, `-`, `+=`, `-=`, `==`, `<` operators for NSDate.

### NSObject

* [`getAssociatedObject`](#NSObject_getAssociatedObject)
* [`setAssociatedObject`](#NSObject_setAssociatedObject)
* [`lazyAssociatedObject`](#NSObject_lazyAssociatedObject)

### NSRegularExpression

* [`init(pattern)`](#NSRegularExpression_initPattern)
* [`exec`](#NSRegularExpression_exec)
* [`test`](#NSRegularExpression_test)

### NSString

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

### NSTimer

* [`schedule`](#NSTimer_schedule)

### Range

* [`each`](#Range_each)
* [`map`](#Range_map)
* [`toArray`](#Range_toArray)

Adds `==` operator for `Range<ForwardIndexType>`.

### UIColor / NSColor

* [`init(argb)`](#UIColor_initARGB)
* [`init(hexString)`](#UIColor_initHexString)
* [`argb`](#UIColor_argb)
* [`hexString`](#UIColor_hexString)

typealias to `NSColor` on non-iOS, missing `init(red, green, blue, alpha)` added.

### UIImage / NSImage

* [`UIImage.imageWithFill`](#UIImage.imageWithFill)
* [`pixelSize`](#UIImage_pixelSize)

typealias to `NSImage` on non-iOS, missing `init(CGImage)` and `CGImage` added.

---------------------------------------
---------------------------------------

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
### Array#indexOf<U: Equatable>(item: U) -> Int?

Return the index of the first array element equal to `item`.

__Arguments__

* `item` - The item to search for
* `returns` A zero-based index for the first matching element in the
array, otherwise nil

__Example__

```
```

---------------------------------------

<a name="Array_indexOf" />
### Array#indexOf(condition: TestCallback) -> Int?

Return the index of the first array element where the supplied function
returns true.

__Arguments__

* `condition` - Function that takes an array element and returns true
for a match, otherwise false
* `returns` A zero-based index for the first matching element in the
array, otherwise nil

__Example__

```
```

---------------------------------------

<a name="Array_each" />
### Array#each(function: ElementCallback)

Execute a function for each element in the array.

__Arguments__

* `function` - Function to run for each element

__Example__

```
```

---------------------------------------

<a name="Array_each" />
### Array#each(function: IndexedElementCallback)

Execute a function for each index and element tuple in the array.

__Arguments__

* `function` - Function to run for each index and element tuple

__Example__

```
```

---------------------------------------

<a name="Array_contains" />
### Array#contains<T: Equatable>(items: T...) -> Bool

Test if the array contains one or more elements.

__Arguments__

* `items` - One or more elements to search for in the array. The array
must contain all of the given elements for this method to return true
* `returns` True if all of the given elements were found in the array,
otherwise false

__Example__

```
```

---------------------------------------

<a name="Array_some" />
### Array#some(test: TestCallback) -> Bool

Test if any of the array elements pass a given condition.

__Arguments__

* `test` - Function that takes an array element and returns true or
false
* `returns` True the first time an array element passes the test function,
otherwise false

__Example__

```
```

---------------------------------------

<a name="Array_every" />
### Array#every(test: TestCallback) -> Bool

Test if all of the array elements pass a given condition.

__Arguments__

* `test` - Function that takes an array element and returns true or
false
* `returns` True if every array element passes the test function,
otherwise false the first time an element fails the test

__Example__

```
```

---------------------------------------

<a name="Array_chooseRandom" />
### Array#chooseRandom() -> T?

Return a randomly chosen element from the array

__Arguments__

* `returns` A randomly chosen element, or nil if the array is empty

__Example__

```
```

---------------------------------------

<a name="Array_pop" />
### Array#pop() -> Element?

Remove the last element from the array and return it

__Arguments__

* `returns` The last element in the array, or nil if the array is empty

__Example__

```
```

---------------------------------------

<a name="Array_shift" />
### Array#shift() -> Element?

Remove the first element from the array and return it

__Arguments__

* `returns` The first element in the array, or nil if the array is empty

__Example__

```
```

---------------------------------------

<a name="Array_unshift" />
### Array#unshift(item: T)

Add an element to the beginning of the array

__Arguments__

* `item` - New item to prepend to the array

__Example__

```
```

---------------------------------------

<a name="Array_fill" />
### Array#fill(value: Element, count: Int)

Add an element to the array a given number of times

__Arguments__

* `value` - New element to append to the array
* `count` - Number of times to append the new element

__Example__

```
```

---------------------------------------

<a name="CGRect_aspectFill" />
### CGRect#aspectFill(toRect: CGRect) -> CGRect

Scales this rectangle to fill another rectangle. Some portion of this
rectangle may extend beyond the bounds of the target rectangle to fill
 the target rectangle

__Arguments__

* `toRect` - Target rectangle to fill
* `returns` A copy of this rectangle, scaled to fill the target rectangle

__Example__

```
```

---------------------------------------

<a name="CGRect_aspectFit" />
### CGRect#aspectFit(toRect: CGRect) -> CGRect

Scales this rectangle to fill the interior of another rectangle while
maintaining this rectangle's aspect ratio

__Arguments__

* `toRect` - Target rectangle to fit inside of
* `returns` A copy of this rectangle, scaled to fit the target rectangle

__Example__

```
```

---------------------------------------

<a name="CGSize_aspectFill" />
### CGSize#aspectFill(toSize: CGSize) -> CGSize

Scales this size to fill a rectangle. Some portion of this size may
extend beyond the bounds of the rectangle to fill the rectangle

__Arguments__

* `toRect` - Target rectangle to fill
* `returns` A copy of this size, scaled to fill the target rectangle

__Example__

```
```

---------------------------------------

<a name="CGSize_aspectFit" />
### CGSize#aspectFit(toSize: CGSize) -> CGSize

Scales this size to fill the interior of a rectangle while maintaining
this size's aspect ratio

__Arguments__

* `toRect` - Target rectangle to fit inside of
* `returns` A copy of this size, scaled to fit the target rectangle

__Example__

```
```

---------------------------------------

<a name="Dictionary.sortByKeys" />
### Dictionary.sortByKeys<K: Comparable, V>(dictionary: [K: V]) -> [V]

Convert a dictionary to an array of values sorted by the dictionary keys

__Arguments__

* `dictionary` - Dictionary to sort
* `returns` An array of values sorted by their corresponding keys in the
dictionary

__Example__

```
```

---------------------------------------

<a name="Dictionary_map" />
### Dictionary#map<K: Hashable, V> (transform: (Key, Value) -> (K, V)) -> [K: V]

Map all of the `(key, value)` tuples in this dictionary to new key value
pairs in a new dictionary. The behavior is undefined for two or more
 keys mapping to the same output key

__Arguments__

* `transform` - Function that is called once for each key value pair
and returns a new key value pair
* `returns` Dictionary consisting of the mapped key value pairs

__Example__

```
```

---------------------------------------

<a name="Double_abs" />
### Double#abs() -> Double

Return the absolute value of this number

__Arguments__

* `returns` `fabs(self)`

__Example__

```
```

---------------------------------------

<a name="Double_sqrt" />
### Double#sqrt() -> Double

Return the square root of this number

__Arguments__

* `returns` `sqrt(self)`

__Example__

```
```

---------------------------------------

<a name="Double_floor" />
### Double#floor() -> Double

Return this number rounded down to the nearest whole number

__Arguments__

* `returns` `floor(self)`

__Example__

```
```

---------------------------------------

<a name="Double_ceil" />
### Double#ceil() -> Double

Return this number rounded up to the nearest whole number

__Arguments__

* `returns` `ceil(self)`

__Example__

```
```

---------------------------------------

<a name="Double_round" />
### Double#round() -> Double

Return this number rounded to the nearest whole number

__Arguments__

* `returns` `round(self)`

__Example__

```
```

---------------------------------------

<a name="Double_clamp" />
### Double#clamp(min: Double, _ max: Double) -> Double

Return this value clamped to the closed interval defined by `min` and
`max`

__Arguments__

* `min` - Inclusive minimum value
* `max` - Inclusive maximum value
* `returns` `Swift.max(min, Swift.min(max, self))`

__Example__

```
```

---------------------------------------

<a name="Double.random" />
### Double.random(min: Double = 0, max: Double = 1) -> Double

Return a uniformly distributed random number in the half open interval
`[min, max)`

__Arguments__

* `min` - Inclusive minimum value
* `max` - Exclusive maximum value
* `returns` A random number within the given interval

__Example__

```
```

---------------------------------------

<a name="NSData_base64URLEncode" />
### NSData#base64URLEncode() -> String

Convert this NSData to a URL-safe base64 encoded string. URL-safe
encoding replaces `+` and `/` with `-` and `_`, respectively, and does
 not contain `=` padding characters. For more information see
 <https://en.wikipedia.org/wiki/Base64#URL_applications>

__Arguments__

* `returns` A URL-safe base64 encoded string

__Example__

```
```

---------------------------------------

<a name="NSData_toHexString" />
### NSData#toHexString() -> String

Convert this NSData to a hexadecimal string. The output will not include
a "0x" prefix

__Arguments__

* `returns` A hexadecimal string

__Example__

```
```

---------------------------------------

<a name="NSDate_currentTZOffset" />
### NSDate#currentTZOffset() -> NSTimeInterval

Returns the current system local timezone as the number of seconds
offset from GMT.

__Arguments__

* `returns` Example: -25200 seconds for Pacific Daylight Time

__Example__

```
```

---------------------------------------

<a name="NSDate_currentTZOffsetMinutes" />
### NSDate#currentTZOffsetMinutes() -> Int

Returns the current system local timezone as the number of minutes
offset from GMT.
 :returns: Example: -420 minutes for Pacific Daylight Time

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_toISOString" />
### NSDate#toISOString() -> String

Returns this date as an ISO 8601 string.

__Arguments__

* `returns` ISO 8601 formatted string

__Example__

```
```

---------------------------------------

<a name="NSDate_toRFC3339String" />
### NSDate#toRFC3339String() -> String

Returns this date as an RFC 3339 string.

__Arguments__

* `returns` RFC 3339 formatted string

__Example__

```
```

---------------------------------------

<a name="NSDate_unixTimestamp" />
### NSDate#unixTimestamp() -> Int64

Returns this date as a UNIX timestamp (number of whole seconds passed
since the UNIX epoch).

__Arguments__

* `returns` 64-bit integer timestamp

__Example__

```
```

---------------------------------------

<a name="NSDate_shortRelativeString" />
### NSDate#shortRelativeString(otherDate: NSDate) -> String

Returns the difference between this date and another date as a short
human-friendly string. Examples: "now", "3m", "5h", "1w", "2015y".

__Arguments__

* `otherDate` - Other date to compare this date against. The absolute
difference between the two dates is used.
* `returns` A short string representation of the time difference between
the two dates

__Example__

```
```

---------------------------------------

<a name="NSDate_midnight" />
### NSDate#midnight() -> NSDate

Returns an NSDate for midnight of the same day as this date.

__Arguments__

* `returns` NSDate at midnight

__Example__

```
```

---------------------------------------

<a name="NSDate_addSeconds" />
### NSDate#addSeconds(seconds: Int) -> NSDate

Returns a new date by adding seconds to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_addMinutes" />
### NSDate#addMinutes(minutes: Int) -> NSDate

Returns a new date by adding minutes to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_addHours" />
### NSDate#addHours(hours: Int) -> NSDate

Returns a new date by adding hours to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_addDays" />
### NSDate#addDays(days: Int) -> NSDate

Returns a new date by adding days to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_addWeeks" />
### NSDate#addWeeks(weeks: Int) -> NSDate

Returns a new date by adding weeks to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_addMonths" />
### NSDate#addMonths(months: Int) -> NSDate

Returns a new date by adding months to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_addYears" />
### NSDate#addYears(years: Int) -> NSDate

Returns a new date by adding years to the current date.

__Arguments__



__Example__

```
```

---------------------------------------

<a name="NSDate_isAfter" />
### NSDate#isAfter(date: NSDate) -> Bool

Test if a given date occurs after this date.

__Arguments__

* `date` - Date to test against this date
* `returns` True if the given date is ahead of this date, otherwise false
if it is equal to or behind this date.

__Example__

```
```

---------------------------------------

<a name="NSDate_isBefore" />
### NSDate#isBefore(date: NSDate) -> Bool

Test if a given date occurs before this date.

__Arguments__

* `date` - Date to test against this date
* `returns` True if the given date is behind this date, otherwise false
if it is equal to or ahead of this date.

__Example__

```
```

---------------------------------------

<a name="NSObject_getAssociatedObject" />
### NSObject#getAssociatedObject<T: NSObject>(key: UnsafePointer<Void>) -> T?

Retrieve an associated object. Associated objects allow NSObject-derived
objects to be associated with a parent NSObject-derived object and a
 given key. They are particularly useful for adding new members to an
 object via extensions.

__Arguments__

* `key` - Key used to store the associated object being retrieved
* `returns` Value associated with the given key on this object if it
exists and matches the expected type, otherwise nil

__Example__

```
```

---------------------------------------

<a name="NSObject_setAssociatedObject" />
### NSObject#setAssociatedObject<T: NSObject>(key: UnsafePointer<Void>, value: T)

Set an associated object. Associated objects allow NSObject-derived
objects to be associated with a parent NSObject-derived object and a
 given key. They are particularly useful for adding new members to an
 object via extensions

__Arguments__

* `key` - Key used to store the associated object
* `value` - Object to store

__Example__

```
```

---------------------------------------

<a name="NSObject_lazyAssociatedObject" />
### NSObject#lazyAssociatedObject<T: NSObject>(key: UnsafePointer<Void>, initializer: () -> T) -> T

Retrieve an associated object that is lazily initialized. See
`getAssociatedObject` for more information on associated objects.

__Arguments__

* `key` - Key used to store the associated object being retrieved
* `initializer` - Function that instantiates the associated object.
This method is run only once the first time the object is accessed

__Example__

```
```

---------------------------------------

<a name="NSRegularExpression_exec" />
### NSRegularExpression#exec(string: String) -> RegExpMatches

Execute this regular expression against a given string and return all
matches and capture groups.

__Arguments__

* `haystack` - The string to execute this regular expression against
* `returns` A `RegExpMatches` object containing each match which in turn
contains the matching value, range, and capture groups

__Example__

```
```

---------------------------------------

<a name="NSRegularExpression_test" />
### NSRegularExpression#test(string: String) -> Bool

Test if this regular expression matches one or more times against a
given string.

__Arguments__

* `string` - The string to test this regular expression against
* `returns` True ifthe regular expression matched one or more times,
otherwise false

__Example__

```
```

---------------------------------------

<a name="NSString_startsWith" />
### NSString#startsWith(prefix: String) -> Bool

Test if this string starts with a given string.

__Arguments__

* `prefix` - String to test against the beginning of the current
string
* `returns` True if this string starts with the given prefix

__Example__

```
```

---------------------------------------

<a name="NSString_endsWith" />
### NSString#endsWith(suffix: String) -> Bool

Test if this string ends with a given string.

__Arguments__

* `suffix` - String to test against the ending of the current string
* `returns` True if this string ends with the given suffix

__Example__

```
```

---------------------------------------

<a name="NSString_contains" />
### NSString#contains(needle: String) -> Bool

Test if this string contains a given string.

__Arguments__

* `needle` - String to search for
* `returns` True if this string contains the given string

__Example__

```
```

---------------------------------------

<a name="NSString_match" />
### NSString#match(regex: RegExp) -> [String]

Find all matches in this string for a given regular expression. This
method does not support capture groups (use `RegExp#exec()`).

__Arguments__

* `regex` - Regular expression to execute against this string
* `returns` Array of zero or more

__Example__

```
```

---------------------------------------

<a name="NSString_replace" />
### NSString#replace(target: String, withString replacement: String, options: NSStringCompareOptions = .LiteralSearch, range searchRange: Range<Int>? = nil) -> String

Returns a new string by replacing all instances of a given substring
with another string.

__Arguments__

* `target` - Substring to search and replace in this string
* `withString` - Replacement string
* `options` - String comparison options
* `range` - Limit search and replace to a specific range
* `returns` New string with all instances of `target` replaced by
`withString`

__Example__

```
```

---------------------------------------

<a name="NSString_split" />
### NSString#split(separator: String) -> [String]

Returns an array containing substrings from this string that have been
divided by a given separator.

__Arguments__

* `separator` - Separator string to split on. Example: ":"
* `returns` Array of substrings

__Example__

```
```

---------------------------------------

<a name="NSString_split" />
### NSString#split(separators: NSCharacterSet) -> [String]

Returns an array containing substrings from this string that have been
divided by a given set of separator characters.

__Arguments__

* `separators` - Separator characters to split on
* `returns` Array of substrings

__Example__

```
```

---------------------------------------

<a name="NSString_substr" />
### NSString#substr(range: Range<Int>) -> String

Returns a substring specified by a given character range.

__Arguments__

* `range` - Character range to extract
* `returns` Extracted substring

__Example__

```
```

---------------------------------------

<a name="NSString_substr" />
### NSString#substr(range: Range<String.Index>) -> String

Returns a substring specified by a given string range.

__Arguments__

* `range` - String range to extract
* `returns` Extracted substring

__Example__

```
```

---------------------------------------

<a name="NSString_substr" />
### NSString#substr(startIndex: Int) -> String

Returns a substring starting at the specified character offset.

__Arguments__

* `startIndex` - Inclusive starting character index
* `returns` Extracted substring

__Example__

```
```

---------------------------------------

<a name="NSString_trim" />
### NSString#trim() -> String

Returns a string with leading and trailing whitespace and newlines
removed.

__Arguments__

* `returns` Trimmed string

__Example__

```
```

---------------------------------------

<a name="NSString_uriEncoded" />
### NSString#uriEncoded() -> String

Returns a string with non-URI-safe characters escaped using percent
encoding.

__Arguments__

* `returns` Escaped string

__Example__

```
```

---------------------------------------

<a name="NSString_md5Sum" />
### NSString#md5Sum() -> String

Returns this string's MD5 checksum as a hexidecimal string.

__Arguments__

* `returns` 32 character hexadecimal string

__Example__

```
```

---------------------------------------

<a name="NSString_rangeWithOffsets" />
### NSString#rangeWithOffsets(startOffset: Int = 0, endOffset: Int = 0) -> Range<String.Index>

Construct a string range by specifying relative offsets from the
beginning and end of this string.

__Arguments__

* `startOffset` - Relative offset from the beginning of this string.
Must be >= 0
* `endOffset` - Relative offset from the end of this string. Must be
<= 0
* `returns` `Range<String.Index>` for this string

__Example__

```
```

---------------------------------------

<a name="NSString_toStringRange" />
### NSString#toStringRange(range: Range<Int>) -> Range<String.Index>

Convert a range specified as character positions to a string range.

__Arguments__

* `range` - Character position range. Example: `(0...5)`
* `returns` `Range<String.Index>` for this string

__Example__

```
```

---------------------------------------

<a name="NSString_toStringRange" />
### NSString#toStringRange(range: NSRange) -> Range<String.Index>?

Convert an NSRange to a string range.

__Arguments__

* `NSRange` - to convert
* `returns` `Range<String.Index>` for this string

__Example__

```
```

---------------------------------------

<a name="NSString_fullNSRange" />
### NSString#fullNSRange() -> NSRange

Returns an NSRange representing the entire length of this string.

__Arguments__

* `returns` `NSRange`

__Example__

```
```

---------------------------------------

<a name="NSTimer_schedule" />
### NSTimer#schedule(delay afterDelay: NSTimeInterval, handler: TimerCallback) -> NSTimer

Schedule a function to run once after the specified delay.

__Arguments__

* `delay` - Number of seconds to wait before running the function
* `handler` - Function to run
* `returns` The newly created timer associated with this execution

__Example__

```
```

---------------------------------------

<a name="NSTimer_schedule" />
### NSTimer#schedule(repeatInterval interval: NSTimeInterval, handler: TimerCallback) -> NSTimer

Schedule a function to run continuously with the specified interval.

__Arguments__

* `repeatInterval` - Number of seconds to wait before running the
function the first time, and in between each successive run
* `handler` - Function to return
* `returns` The newly created timer associated with this execution

__Example__

```
```

---------------------------------------

<a name="Range_each" />
### Range#each(function: T -> ())

Execute a function for each element in the range.

__Arguments__

* `function` - Function to run for each element

__Example__

```
```

---------------------------------------

<a name="Range_map" />
### Range#map<V: AnyObject>(function: T -> V) -> [V]

Map each element in this range to an output value.

__Arguments__

* `function` - Function mapping a range element to an output value
* `returns` An array of output values

__Example__

```
```

---------------------------------------

<a name="Range_toArray" />
### Range#toArray() -> [T]

Convert this range to an array.

__Arguments__

* `returns` An array containing each element in the range

__Example__

```
```

---------------------------------------

<a name="UIImage_imageWithFill" />
### UIImage#imageWithFill(color: UIColor) -> UIImage

Create a 1x1 image filled with the specified color.

__Arguments__

* `color` - Color to fill the image with
* `returns` New UIImage containing one pixel of the specified color

__Example__

```
```

---------------------------------------

<a name="MD5_arrayOfBytes" />
### MD5#arrayOfBytes<T>(value: T, length: Int? = nil) -> [UInt8]

Array of bytes, little-endian representation. Don't use if not necessary.
I found this method slow

__Arguments__



__Example__

```
```

---------------------------------------

<a name="Math_lerp" />
### Math#lerp(a: Float, b: Float, t: Float) -> Float

Linearly interpolate between two values.

__Arguments__

* `a` - Starting value
* `b` - Ending value
* `t` - Percent to interpolate from `a` to `b`, usually in the range [0-1]
* `returns` The interpolated value

__Example__

```
```

---------------------------------------

<a name="Math_lerp" />
### Math#lerp(a: Double, b: Double, t: Double) -> Double

Linearly interpolate between two values.

__Arguments__

* `a` - Starting value
* `b` - Ending value
* `t` - Percent to interpolate from `a` to `b`, usually in the range [0-1]
* `returns` The interpolated value

__Example__

```
```

---------------------------------------

<a name="Threading_runOnMainThread" />
### Threading#runOnMainThread(block: dispatch_block_t)

Asynchronously schedule a function for execution on the main thread

__Arguments__

* `block` - Function to run on the main thread in the (near) future

__Example__

```
```

---------------------------------------

<a name="Threading_runOnMainThreadIfNeeded" />
### Threading#runOnMainThreadIfNeeded(block: dispatch_block_t)

Asynchronously schedule a function for execution on the main thread if we're
currently on a background thread, otherwise synchronously run the function
 immediately.

__Arguments__

* `block` - Function to either asynchronously schedule or run immediately

__Example__

```
```

---------------------------------------

<a name="Threading_runOnMainThreadIfNeededSync" />
### Threading#runOnMainThreadIfNeededSync(block: dispatch_block_t)

Schedule a function for execution on the main thread and block execution on
the current background thread until it completes, or synchronously run the
 function immediately if we're already on the main thread.

__Arguments__

* `block` - Function to either synchronously schedule or run immediately

__Example__

```
```

---------------------------------------

<a name="Threading_runOnMainThreadAfterDelay" />
### Threading#runOnMainThreadAfterDelay(delay: NSTimeInterval, block: dispatch_block_t)

Asynchronously schedule a function for execution on the main thread after at
least the given delay.

__Arguments__

* `delay` - Minimum number of seconds to wait before execution
* `block` - Function to run on the main thread in the future

__Example__

```
```

---------------------------------------

<a name="Threading_runAsync" />
### Threading#runAsync(block: dispatch_block_t)

Asynchronously schedule a function for execution on a background thread,
using the default priority global queue.

__Arguments__

* `block` - Function to run on a background thread in the (near) future

__Example__

```
```

---------------------------------------

<a name="Threading_runAsyncAfterDelay" />
### Threading#runAsyncAfterDelay(delay: NSTimeInterval, block: dispatch_block_t)

Asynchronously schedule a function for execution on a background thread
after at least the given delay, using the default priority global queue.

__Arguments__

* `delay` - Minimum number of seconds to wait before execution
* `block` - Function to run on a background thread in the future

__Example__

```
```

---------------------------------------
