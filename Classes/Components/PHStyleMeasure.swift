//
//  PHStyleMeasure.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation

public struct PHStyleMeasure {
    public var value: Double!
    
    public init(valueString: String) throws {
        if let value = parseValueString(valueString) {
            self.value = value
        } else {
            throw PHCSSParserError.WrongStringMeasureFormat(measureString: valueString)
        }
    }
    
    private func parseValueString(valueString: String) -> Double? {
        if valueString.containsString(Constants.MeasurePoints.Pixel) {
            if let value = Double(valueString.stringByReplacingOccurrencesOfString(Constants.MeasurePoints.Pixel, withString: "")) {
                return value
            }
            
        } else if valueString.containsString(Constants.MeasurePoints.Point) {
            if let value = Double(valueString.stringByReplacingOccurrencesOfString(Constants.MeasurePoints.Point, withString: "")) {
                return value
            }
        }
        
        return nil
    }
}