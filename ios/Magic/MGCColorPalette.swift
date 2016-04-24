//
//  MGCColorPalette.swift
//  Magic
//
//  Created by Jason Scharff on 4/23/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

import UIKit

extension UIColor {
  //A method that allows you to use integer instead of floats to create colors.
  convenience init (red: Int, green: Int, blue: Int) {
    let r = CGFloat(red)/255;
    let g = CGFloat(green)/255;
    let b = CGFloat(blue)/255;
    
    self.init(red: r, green: g, blue: b, alpha: 1.0)
  }
 
  //Init from hex string.
  convenience init (hex:String) {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
      cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }
    
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: 1.0)
  }
  
}
