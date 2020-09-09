//
//  Theme.swift
//  Lexicon
//
//  Created by Minh on 11/9/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit

public extension UIColor
{
    public convenience init(hexString: String)
    {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hexString.hasPrefix("#")
        {
            let index   = hexString.index(hexString.startIndex, offsetBy: 1)
            let hex     = hexString.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            
            if scanner.scanHexInt64(&hexValue)
            {
                switch (hex.count)
                {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                    
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                    
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                    
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                    
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                    
                }
                
            } else {
                
                print("Scan hex error")
            }
            
        } else {
            
            print("Invalid RGB string, missing '#' as prefix")
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    
    public class func colorWithHexString (_ hex:String) -> UIColor
    {
        return UIColor(hexString: hex)
    }
}

public extension UIColor {
    public struct Lexikon {
        public static let Pink = UIColor.colorWithHexString("#f8516d")
        public static let Base = UIColor.colorWithHexString("#1d234a")
        public static let Orange = UIColor.colorWithHexString("#f55914")
        public static let Green = UIColor.colorWithHexString("#40c357")
    }
}

