//
//  PHBorderInfo.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation

public enum PHBorderInfoPattern: Int {
    /**
     *  width-color-cornerRadius
     */
    case CornerRadius = 3
    /**
     *  top-left-bottom-right-color
     */
    case Border = 5
    /**
     *  top-offset-left-offset-bottom-offset-right-offset-color
     */
    case BorderWithOffsets = 9
}

public struct PHBorderInfo {
    public var borderLeft: PHStyleMeasure?
    public var borderLeftOffset: PHStyleMeasure?
    public var borderRight: PHStyleMeasure?
    public var borderRightOffset: PHStyleMeasure?
    public var borderTop: PHStyleMeasure?
    public var borderTopOffset: PHStyleMeasure?
    public var borderBottom: PHStyleMeasure?
    public var borderBottomOffset: PHStyleMeasure?
    
    public var borderColorInfo: PHColorInfo?
    public var cornerRadius: PHStyleMeasure?
    
    public init(string: String) throws {
        let parts = string.componentsSeparatedByString("-")
        
        switch parts.count {
        case PHBorderInfoPattern.CornerRadius.rawValue:
            let width = try PHStyleMeasure(valueString: parts[0])
            (borderLeft, borderRight, borderTop, borderBottom) = (width, width, width, width)
            borderColorInfo = try PHColorConverter.colorInfoFromAnyFormat(parts[1])
            cornerRadius = try PHStyleMeasure(valueString: parts[2])
            
        case PHBorderInfoPattern.Border.rawValue:
            borderTop = try PHStyleMeasure(valueString: parts[0])
            borderLeft = try PHStyleMeasure(valueString: parts[1])
            borderBottom = try PHStyleMeasure(valueString: parts[2])
            borderRight = try PHStyleMeasure(valueString: parts[3])
            borderColorInfo = try PHColorConverter.colorInfoFromAnyFormat(parts[4])
        
        case PHBorderInfoPattern.BorderWithOffsets.rawValue:
            borderTop = try PHStyleMeasure(valueString: parts[0])
            borderTopOffset = try PHStyleMeasure(valueString: parts[1])
            borderLeft = try PHStyleMeasure(valueString: parts[2])
            borderLeftOffset = try PHStyleMeasure(valueString: parts[3])
            borderBottom = try PHStyleMeasure(valueString: parts[4])
            borderBottomOffset = try PHStyleMeasure(valueString: parts[5])
            borderRight = try PHStyleMeasure(valueString: parts[6])
            borderRightOffset = try PHStyleMeasure(valueString: parts[7])
            borderColorInfo = try PHColorConverter.colorInfoFromAnyFormat(parts[8])
            
        default:
            throw PHCSSParserError.WrongStringBorderFormat(borderString: string)
        }
    }
}







