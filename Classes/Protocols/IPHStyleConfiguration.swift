//
//  IPHStyleConfiguration.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public enum PHCSSThemeControlState {
    case Normal
    case Highlighted
    case Selected
    case Disabled
}

public protocol IPHStyleConfiguration {
    typealias StateColorInfos = [PHCSSThemeControlState: PHColorInfo]
    
    var fontInfo: PHFontInfo? { get set }
    var textAlignmentInfo: PHTextAlignmentInfo { get set }
    var contentVerticalAlignment: PHContentVerticalAlignmentInfo? { get set }
    var contentHorizontalAlignment: PHContentHorizontalAlignmentInfo? { get set }
    
    var colorInfo: PHColorInfo? { get set }
    var tintColorInfo: PHColorInfo? { get set }
    var backgroundColorInfo: PHColorInfo? { get set }
    var textColorInfo: PHColorInfo? { get set }
    var onTintColor: PHColorInfo? { get set }
    var barTintColor: PHColorInfo? { get set }
    
    var backgroundStateColorInfos: StateColorInfos? { get set }
    var textStateColorInfos: StateColorInfos? { get set }
    
    var underlineStyle: Int? { get set }
}