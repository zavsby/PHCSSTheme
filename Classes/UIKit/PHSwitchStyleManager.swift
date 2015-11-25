//
//  PHSwitchStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHSwitchStyleManager: PHViewStyleManager<UISwitch> {
    override init(view: UISwitch) {
        super.init(view: view)
    }
    
    override func applyStyle(styleConfiguration: IPHStyleConfiguration) {
        super.applyStyle(styleConfiguration)
        
        if let onTintColor = styleConfiguration.onTintColor {
            view.onTintColor = onTintColor.color
        }
    }
}