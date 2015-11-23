//
//  PHContentAlignmentInfo.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public struct PHContentHorizontalAlignmentInfo {
    public let horizontalAlignment: UIControlContentHorizontalAlignment
    
    public init(stringValue: String) {
        switch stringValue {
        case Constants.Alignment.Left:
            horizontalAlignment = .Left
        case Constants.Alignment.Right:
            horizontalAlignment = .Right
        case Constants.Alignment.Center:
            horizontalAlignment = .Center
        default:
            horizontalAlignment = .Center
        }
    }
}

public struct PHContentVerticalAlignmentInfo {
    public let verticalAlignment: UIControlContentVerticalAlignment
    
    public init(stringValue: String) {
        switch stringValue {
        case Constants.Alignment.Top:
            verticalAlignment = .Top
        case Constants.Alignment.Bottom:
            verticalAlignment = .Bottom
        case Constants.Alignment.Center:
            verticalAlignment = .Center
        default:
            verticalAlignment = .Center
        }
    }
}

extension PHContentHorizontalAlignmentInfo: CustomStringConvertible {
    public var description: String {
        return "Horizontal alignment: \(horizontalAlignment)"
    }
}

extension PHContentVerticalAlignmentInfo: CustomStringConvertible {
    public var description: String {
        return "Vertical alignment: \(verticalAlignment)"
    }
}