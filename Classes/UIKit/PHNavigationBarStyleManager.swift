//
//  PHNavigationBarStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHNavigationBarStyleManager: PHViewStyleManager<UINavigationBar> {
    override func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: UINavigationBar) {
        super.applyStyle(styleConfiguration, toView: view)
        
        if let barTintColorInfo = styleConfiguration.onTintColor {
            view.barTintColor = barTintColorInfo.color
        }
    }
}