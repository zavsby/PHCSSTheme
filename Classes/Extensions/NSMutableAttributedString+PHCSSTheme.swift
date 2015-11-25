//
//  NSMutableAttributedString+PHCSSTheme.swift
//  PHCSSTheme
//
//  Created by Sergey on 25.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    public func applyStyleWithKeys(keys: String, range: Range<Int>) {
        try! PHCSSTheme.sharedTheme.applyStyleToAttributedString(self, keys: keys, range: range)
    }
}