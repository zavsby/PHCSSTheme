//
//  IPHStyleConfiguration.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation

public protocol IPHStyleConfiguration {
    var fontInfo: PHFontInfo? { get set }
    var textAlignmentInfo: PHTextAlignmentInfo { get set }
}