//
// SwiftyColor
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS)
  import UIKit
  public typealias Color = UIColor
#elseif os(OSX)
  import AppKit
  public typealias Color = NSColor
#endif

extension Int {
  public var color: Color {
    if self > 16777215 {//ARGB
        let alpha = CGFloat(self as Int >> 24 & 0xff) / 255
        let red = CGFloat(self as Int >> 16 & 0xff) / 255
        let green = CGFloat(self >> 8 & 0xff) / 255
        let blue  = CGFloat(self & 0xff) / 255
        return Color(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    //RGB
    let red = CGFloat(self as Int >> 16 & 0xff) / 255
    let green = CGFloat(self >> 8 & 0xff) / 255
    let blue  = CGFloat(self & 0xff) / 255
    return Color(red: red, green: green, blue: blue, alpha: 1)
  }
}

extension String{
    
    public var color: Color?{
        var colorString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let validatePattern = "^[#]([0-9A-F]{6}|[0-9A-F]{8})$"
        let colorPred = NSPredicate(format:"SELF MATCHES %@", validatePattern)
        let isMatch = colorPred.evaluate(with: self)
        if isMatch{
            colorString.remove(at: colorString.startIndex)
            if colorString.count == 6{ //if color code is RGB add FF as prefix to convert to ARGB
                colorString = "FF\(colorString)"
            }
            var rgbValue:UInt64 = 0
            Scanner(string: colorString).scanHexInt64(&rgbValue)
            return Int(rgbValue).color
        }
        return nil
    }
    
}

precedencegroup AlphaPrecedence {
  associativity: left
  higherThan: RangeFormationPrecedence
  lowerThan: AdditionPrecedence
}

infix operator ~ : AlphaPrecedence

public func ~ (color: Color, alpha: Int) -> Color {
  return color ~ CGFloat(alpha)
}
public func ~ (color: Color, alpha: Float) -> Color {
  return color ~ CGFloat(alpha)
}
public func ~ (color: Color, alpha: CGFloat) -> Color {
  return color.withAlphaComponent(alpha)
}

/// e.g. `50%`
postfix operator %
public postfix func % (percent: Int) -> CGFloat {
  return CGFloat(percent)%
}
public postfix func % (percent: Float) -> CGFloat {
  return CGFloat(percent)%
}
public postfix func % (percent: CGFloat) -> CGFloat {
  return percent / 100
}
