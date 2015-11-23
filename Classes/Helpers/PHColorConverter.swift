//
//  PHColorConverter.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHColorConverter {
    class func colorInfoFromAnyFormat(colorString: String) throws -> PHColorInfo {
        if colorString.hasPrefix("#") {
            return try colorInfoFromHexString(colorString)
        } else if colorString.hasPrefix("rgb(") {
            return try colorInfoFromRGBString(colorString)
        } else {
            throw PHCSSParserError.WrongStringColorFormat(colorString: colorString)
        }
    }
    
    class func colorInfoFromHexString(hexString: String) throws -> PHColorInfo {
        var int = UInt32()
        NSScanner(string: hexString).scanHexInt(&int)
        
        let a, r, g, b: UInt32
        
        switch hexString.characters.count {
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // RGBA (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            throw PHCSSParserError.WrongStringColorFormat(colorString: hexString)
        }
        
        return PHColorInfo(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, alpha: Double(a) / 255)
    }
    
    class func colorInfoFromRGBString(rgbString: String) throws -> PHColorInfo {
        var commaSeparatedString = rgbString.stringByReplacingOccurrencesOfString("rgb(", withString: "")
        commaSeparatedString = commaSeparatedString.stringByReplacingOccurrencesOfString(")", withString: "")
        return try colorInfoFromCommaSeparatedRGBAString(commaSeparatedString)
    }
    
    private class func colorInfoFromCommaSeparatedRGBAString(rgbaString: String) throws -> PHColorInfo {
        let colorStrings = rgbaString.componentsSeparatedByString(",")
        
        guard colorStrings.count >= 3 else {
            throw PHCSSParserError.WrongStringColorFormat(colorString: rgbaString)
        }
        
        var colors: [Double] = []
        for colorString in colorStrings {
            if let color = Double(colorString) {
                colors.append(color)
            } else {
                throw PHCSSParserError.WrongStringColorFormat(colorString: rgbaString)
            }
        }
        
        let alpha = colors.count == 4 ? colors[3] : 1.0
        return PHColorInfo(red: colors[0], green: colors[1], blue: colors[2], alpha: alpha)
    }
}