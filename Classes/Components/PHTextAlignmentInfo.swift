//
//  PHTextAlignmentInfo.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public struct PHTextAlignmentInfo {
    public let textAlignment: NSTextAlignment
    
    public init(stringValue: String) {
        switch stringValue {
        case Constants.Alignment.Left:
            textAlignment = .Left
        case Constants.Alignment.Right:
            textAlignment = .Right
        case Constants.Alignment.Center:
            textAlignment = .Center
        case Constants.Alignment.Justified:
            textAlignment = .Justified
        default:
            print("CSS Parser error: unsupported text alignment '\(stringValue)'. Assuming left text alignment.")
            textAlignment = .Left
        }
    }
}

extension PHTextAlignmentInfo: CustomStringConvertible {
    public var description: String {
        return "Text alignment: \(textAlignment)"
    }
}