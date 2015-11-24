//
//  PHSegmentedControlStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHSegmentedControlStyleManager: PHViewStyleManager<UISegmentedControl> {
    override func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: UISegmentedControl) {
        super.applyStyle(styleConfiguration, toView: view)
        
        var titleAttributes: [NSObject: AnyObject] = [:]
        if let fontInfo = styleConfiguration.fontInfo {
            titleAttributes[NSFontAttributeName] = fontInfo.font
        }
        
        if styleConfiguration.textStateColorInfos.count > 0 {
            if let colorInfo = styleConfiguration.textStateColorInfos[.Normal] {
                var attributesCopy = titleAttributes
                attributesCopy[NSForegroundColorAttributeName] = colorInfo.color
                view.setTitleTextAttributes(attributesCopy, forState: .Normal)
            }
            
            if let colorInfo = styleConfiguration.textStateColorInfos[.Highlighted] {
                var attributesCopy = titleAttributes
                attributesCopy[NSForegroundColorAttributeName] = colorInfo.color
                view.setTitleTextAttributes(attributesCopy, forState: .Highlighted)
            }
            
            if let colorInfo = styleConfiguration.textStateColorInfos[.Selected] {
                var attributesCopy = titleAttributes
                attributesCopy[NSForegroundColorAttributeName] = colorInfo.color
                view.setTitleTextAttributes(attributesCopy, forState: .Selected)
            }
            
            if let colorInfo = styleConfiguration.textStateColorInfos[.Disabled] {
                var attributesCopy = titleAttributes
                attributesCopy[NSForegroundColorAttributeName] = colorInfo.color
                view.setTitleTextAttributes(attributesCopy, forState: .Disabled)
            }
            
        } else {
            if let textColorInfo = styleConfiguration.textColorInfo {
                titleAttributes[NSForegroundColorAttributeName] = textColorInfo.color
            }
            
            if titleAttributes.count > 0 {
                view.setTitleTextAttributes(titleAttributes, forState: .Normal)
            }
        }
        
        if styleConfiguration.backgroundStateColorInfos.count > 0 {
            if let normalBgColorInfo = styleConfiguration.backgroundStateColorInfos[.Normal] {
                let image = PHCSSImageUtils.imageWithColor(normalBgColorInfo.color)
                view.setBackgroundImage(image, forState: .Normal, barMetrics: .Default)
            }
            
            if let highlightedBgInfo = styleConfiguration.backgroundStateColorInfos[.Highlighted] {
                let image = PHCSSImageUtils.imageWithColor(highlightedBgInfo.color)
                view.setBackgroundImage(image, forState: .Highlighted, barMetrics: .Default)
            }
            
            if let selectedBgInfo = styleConfiguration.backgroundStateColorInfos[.Selected] {
                let image = PHCSSImageUtils.imageWithColor(selectedBgInfo.color)
                view.setBackgroundImage(image, forState: .Selected, barMetrics: .Default)
            }
            
            if let disabledBgInfo = styleConfiguration.backgroundStateColorInfos[.Disabled] {
                let image = PHCSSImageUtils.imageWithColor(disabledBgInfo.color)
                view.setBackgroundImage(image, forState: .Disabled, barMetrics: .Default)
            }
        }
    }
    
}