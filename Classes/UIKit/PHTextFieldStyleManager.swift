//
//  PHTextFieldStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHTextFieldStyleManager: PHViewStyleManager<UITextField> {
    override func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: UITextField) {
        super.applyStyle(styleConfiguration, toView: view)
        
        if let textColorInfo = styleConfiguration.textColorInfo {
            view.textColor = textColorInfo.color
        }
        
        if let textAlignmentInfo = styleConfiguration.textAlignmentInfo {
            view.textAlignment = textAlignmentInfo.textAlignment
        }
        
        if let fontInfo = styleConfiguration.fontInfo {
            view.font = fontInfo.font
        }
    }
}