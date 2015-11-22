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
            textAlignment = .Left
        }
    }
}