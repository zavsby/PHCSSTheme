//
//  PHViewStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHViewStyleManager<T: UIView> {
    func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: T) {
        if let backgroundColorInfo = styleConfiguration.backgroundColorInfo {
            view.backgroundColor = backgroundColorInfo.color
        }
        
        if let tintColor = styleConfiguration.tintColorInfo {
            view.tintColor = tintColor.color
        }
        
        if let borderInfo = styleConfiguration.borderInfo {
            if let borderRadius = borderInfo.cornerRadius {
                view.layer.masksToBounds = true
                view.layer.borderColor = borderInfo.borderColorInfo.color.CGColor
                view.layer.borderWidth = CGFloat(borderInfo.borderLeft.value)
                view.layer.cornerRadius = CGFloat(borderRadius.value)
            } else {
                // TODO: add borders for type 2 and 3
            }
        }
    }
}