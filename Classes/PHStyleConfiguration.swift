//
//  PHStyleConfiguration.swift
//  PHCSSTheme
//
//  Created by Sergey on 22.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public class PHStyleConfiguration: IPHStyleConfiguration {
    var isEmpty: Bool {
        return false
    }
    
    public init(values: [String: String]) {
        do {
            try parseFromValues(values)
        } catch PHCSSParserError.WrongStringColorFormat(let colorString) {
            print("CSS Parser error! Unable to parse color string: \(colorString)")
        } catch {
            print("CSS Parser error! Uknown exception.")
        }
    }
    
    private func parseFromValues(values: [String: String]) throws {
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
                
            case Constants.Property.FontFamilyName:
                fontInfo = PHFontInfo(fontName: value)
                
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
    
    public lazy var backgroundStateColorInfos: StateColorInfos = [:]
    public lazy var textStateColorInfos: StateColorInfos = [:]
    
    public var underlineStyle: NSUnderlineStyle?
}