//
//  PHButtonStyleConfiguration.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHButtonStyleConfiguration: PHViewStyleManager<UIButton> {
    override func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: UIButton) {
        super.applyStyle(styleConfiguration, toView: view)
        
        if let fontInfo = styleConfiguration.fontInfo {
            view.titleLabel?.font = fontInfo.font
        }
        
        if let textAlignment = styleConfiguration.textAlignmentInfo {
            switch textAlignment.textAlignment {
            case .Left:
                view.contentHorizontalAlignment = .Left
            case .Right:
                view.contentHorizontalAlignment = .Right
            case .Center:
                view.contentHorizontalAlignment = .Center
            default:
                view.contentHorizontalAlignment = .Left
            }
        }
        
        if let verticalAlignment = styleConfiguration.contentVerticalAlignment {
            view.contentVerticalAlignment = verticalAlignment.verticalAlignment
        }
        
        if styleConfiguration.textStateColorInfos.count > 0 {
            if let normalTextColorInfo = styleConfiguration.textStateColorInfos[.Normal] {
                view.setTitleColor(normalTextColorInfo.color, forState: .Normal)
            }
            
            if let highlightedTextColorInfo = styleConfiguration.textStateColorInfos[.Highlighted] {
                view.setTitleColor(highlightedTextColorInfo.color, forState: .Highlighted)
            }
            
            if let selectedTextColorInfo = styleConfiguration.textStateColorInfos[.Selected] {
                view.setTitleColor(selectedTextColorInfo.color, forState: .Selected)
            }
            
            if let disabledTextColorInfo = styleConfiguration.textStateColorInfos[.Disabled] {
                view.setTitleColor(disabledTextColorInfo.color, forState: .Disabled)
            }
            
        } else if let textColorInfo = styleConfiguration.textColorInfo {
            view.setTitleColor(textColorInfo.color, forState: .Normal)
        }
        
        if styleConfiguration.backgroundStateColorInfos.count > 0 {
            if let normalBgColorInfo = styleConfiguration.backgroundStateColorInfos[.Normal] {
                view.setBackgroundImage(PHCSSImageUtils.imageWithColor(normalBgColorInfo.color), forState: .Normal)
            }
            
            if let highlightedBgInfo = styleConfiguration.backgroundStateColorInfos[.Highlighted] {
                view.setBackgroundImage(PHCSSImageUtils.imageWithColor(highlightedBgInfo.color), forState: .Highlighted)
            }
            
            if let selectedBgInfo = styleConfiguration.backgroundStateColorInfos[.Selected] {
                view.setBackgroundImage(PHCSSImageUtils.imageWithColor(selectedBgInfo.color), forState: .Selected)
            }
            
            if let disabledBgInfo = styleConfiguration.backgroundStateColorInfos[.Disabled] {
                view.setBackgroundImage(PHCSSImageUtils.imageWithColor(disabledBgInfo.color), forState: .Disabled)
            }
        }
    }
}