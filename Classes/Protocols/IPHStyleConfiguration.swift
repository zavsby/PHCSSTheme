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

public typealias StateColorInfos = [PHCSSThemeControlState: PHColorInfo]

public protocol IPHStyleConfiguration {
    var fontInfo: PHFontInfo? { get }
    var textAlignmentInfo: PHTextAlignmentInfo? { get }
    var contentVerticalAlignment: PHContentVerticalAlignmentInfo? { get }
    var contentHorizontalAlignment: PHContentHorizontalAlignmentInfo? { get }

    var colorInfo: PHColorInfo? { get }
    var tintColorInfo: PHColorInfo? { get }
    var backgroundColorInfo: PHColorInfo? { get }
    var textColorInfo: PHColorInfo? { get }
    var onTintColor: PHColorInfo? { get }
    var barTintColor: PHColorInfo? { get }

    var backgroundStateColorInfos: StateColorInfos { get }
    var textStateColorInfos: StateColorInfos { get }
    
    var underlineStyle: NSUnderlineStyle? { get }
    
    var borderInfo: PHBorderInfo? { get }
    
    
    init(values: [String: String]) throws
    
    /**
     Merges given configuration with the receiver. Given configuration will replace nonnull components of the receiver.
     
     - parameter configuration: Configuration to be merged with
     - returns: New merged style configuration
     */
    func mergedConfigurationWithConfiguration(configuration: IPHStyleConfiguration) -> IPHStyleConfiguration
}