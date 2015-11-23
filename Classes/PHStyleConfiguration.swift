//
//  PHStyleConfiguration.swift
//  PHCSSTheme
//
//  Created by Sergey on 22.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public struct PHStyleConfiguration: IPHStyleConfiguration {
    var isEmpty: Bool {
        return false
    }
    
    public init(values: [String: String]) {
        do {
            try parseFromValues(values)
        } catch PHCSSParserError.WrongStringColorFormat(let colorString) {
            print("CSS Parser error! Unable to parse color string: \(colorString)")
        } catch PHCSSParserError.WrongStringMeasureFormat(let measureString) {
            print("CSS Parser error! Unable to parse measure string: \(measureString)")
        } catch {
            print("CSS Parser error! Unknown exception.")
        }
    }
    
    private mutating func parseFromValues(values: [String: String]) throws {
        if let fontName = values[Constants.Property.FontFamilyName] {
            if let fontSize = values[Constants.Property.FontSize] {
                let fontSizeMeasure = try PHStyleMeasure(valueString: fontSize)
                fontInfo = PHFontInfo(fontName: fontName, fontSize: fontSizeMeasure.value)
            } else {
                fontInfo = PHFontInfo(fontName: fontName)
            }
        }
        
        for (key, value) in values {
            switch key {
            case Constants.Property.TextColor:
                textColorInfo = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.ColorNormal:
                textStateColorInfos[.Normal] = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.ColorHighlighted:
                textStateColorInfos[.Highlighted] = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.ColorSelected:
                textStateColorInfos[.Selected] = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.ColorDisabled:
                textStateColorInfos[.Disabled] = try PHColorConverter.colorInfoFromAnyFormat(value)
                
            case Constants.Property.BackgroundColor:
                backgroundColorInfo = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.BackgroundColorNormal:
                textStateColorInfos[.Normal] = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.BackgroundColorHighlighted:
                textStateColorInfos[.Highlighted] = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.BackgroundColorSelected:
                textStateColorInfos[.Selected] = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.BackgroundColorDisabled:
                textStateColorInfos[.Disabled] = try PHColorConverter.colorInfoFromAnyFormat(value)
                
            case Constants.Property.TintColor:
                tintColorInfo = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.OnTintColor:
                onTintColor = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.BarTintColor:
                barTintColor = try PHColorConverter.colorInfoFromAnyFormat(value)
            case Constants.Property.Color:
                colorInfo = try PHColorConverter.colorInfoFromAnyFormat(value)
                
            case Constants.Property.TextAlignment:
                textAlignmentInfo = PHTextAlignmentInfo(stringValue: value)
            case Constants.Property.HorizontalAlignment:
                contentHorizontalAlignment = PHContentHorizontalAlignmentInfo(stringValue: value)
            case Constants.Property.VerticalAlignment:
                contentVerticalAlignment = PHContentVerticalAlignmentInfo(stringValue: value)
                
            case Constants.Property.TextDecoration:
                if value == Constants.TextDecoration.Underline {
                    underlineStyle = .StyleSingle
                }
                
            case Constants.Property.Border:
                borderInfo = try PHBorderInfo(string: value)
                
            case Constants.Property.FontFamilyName, Constants.Property.FontSize:
                break
                
            default:
                print("CSS Parser error: unsupported attribute \(key)")
            }
        }
    }
    
    // MARK:- IPHStyleConfuguration protocol
    public var fontInfo: PHFontInfo?
    public var textAlignmentInfo: PHTextAlignmentInfo?
    public var contentVerticalAlignment: PHContentVerticalAlignmentInfo?
    public var contentHorizontalAlignment: PHContentHorizontalAlignmentInfo?
    
    public var colorInfo: PHColorInfo?
    public var tintColorInfo: PHColorInfo?
    public var backgroundColorInfo: PHColorInfo?
    public var textColorInfo: PHColorInfo?
    public var onTintColor: PHColorInfo?
    public var barTintColor: PHColorInfo?
    
    public var backgroundStateColorInfos: StateColorInfos = [:]
    public var textStateColorInfos: StateColorInfos = [:]
    
    public var underlineStyle: NSUnderlineStyle?
    
    public var borderInfo: PHBorderInfo?
}
