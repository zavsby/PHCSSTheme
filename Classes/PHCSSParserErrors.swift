//
//  PHCSSParserErrors.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation

public enum PHCSSParserError: ErrorType {
    case WrongStringColorFormat(colorString: String)
    case WrongStringMeasureFormat(measureString: String)
}