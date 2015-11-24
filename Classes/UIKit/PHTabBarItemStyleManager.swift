//
//  PHTabBarItemStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHTabBarItemStyleManager {
    func applyStyle(styleConfiguration: PHStyleConfiguration, toTabBarItem tabBarItem: UITabBarItem) {
        var titleNormalAttributes: [String : AnyObject] = [:]
        var titleSelectedAttributes: [String: AnyObject] = [:]
        
        if let fontInfo = styleConfiguration.fontInfo {
            titleNormalAttributes[NSFontAttributeName] = fontInfo.font
            titleSelectedAttributes[NSFontAttributeName] = fontInfo.font
        }
        
        if styleConfiguration.textStateColorInfos.count > 0 {
            if let normalTextColorInfo = styleConfiguration.textStateColorInfos[.Normal] {
                titleNormalAttributes[NSForegroundColorAttributeName] = normalTextColorInfo.color
            }
            if let selectedTextColorInfo = styleConfiguration.textStateColorInfos[.Selected] {
                titleSelectedAttributes[NSForegroundColorAttributeName] = selectedTextColorInfo.color
            }
        }
        
        if titleNormalAttributes.count > 0 {
            tabBarItem.setTitleTextAttributes(titleNormalAttributes, forState: .Normal)
        }
        if titleSelectedAttributes.count > 0 {
            tabBarItem.setTitleTextAttributes(titleSelectedAttributes, forState: .Selected)
        }
    }
}