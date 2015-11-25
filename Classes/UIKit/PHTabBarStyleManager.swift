//
//  PHTabBarStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHTabBarStyleManager: PHViewStyleManager<UITabBar> {
    override init(view: UITabBar) {
        super.init(view: view)
    }
    
    override func applyStyle(styleConfiguration: IPHStyleConfiguration) {
        super.applyStyle(styleConfiguration)
        
        if let backgroundColorInfo = styleConfiguration.backgroundColorInfo {
            view.barTintColor = backgroundColorInfo.color
        }
    }
}