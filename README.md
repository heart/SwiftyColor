SwiftyColor
===========

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/SwiftyColor.svg?style=flat)](http://cocoapods.org/?q=name%3ASwiftyColor%20author%3Adevxoul)
[![CI](https://github.com/devxoul/SwiftyColor/workflows/CI/badge.svg)](http://github.com/devxoul/SwiftyColor/actions)

The most sexy way to use colors in Swift. Both compatible with iOS and macOS.

Color from Hex int
--------------

```swift
//RGB
let color = 0x123456.color
```

```swift
//ARGB
let colorWithAlpha = 0xFF123456.color
```

Color from Hex string color code
--------------
```swift
//#RGB
let color = "#123456".color
```

```swift
//#ARGB
let colorWithAlpha = "#FF123456".color
```


Alpha Operator
--------------

Use infix operator `~`.

```swift
let transparent = 0x123456.color ~ 50%
let red = UIColor.red ~ 10%
let float = UIColor.blue ~ 0.5 // == 50%
```

Percent Operator
----------------

```swift
let view = UIView()
view.alpha = 30% // == 0.3
```

License
-------

SwiftyColor is under MIT license. See LICENSE file for more information.
