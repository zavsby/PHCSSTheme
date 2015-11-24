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
    override func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: UITabBar) {
        super.applyStyle(styleConfiguration, toView: view)
        
        if let backgroundColorInfo = styleConfiguration.backgroundColorInfo {
            view.barTintColor = backgroundColorInfo.color
        }
    }
}