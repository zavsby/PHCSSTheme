//
//  PHViewStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHViewStyleManager<T: UIView> : IPHStyleManager {
    let view: T
    
    init(view: T) {
        self.view = view
    }
    
    func applyStyle(styleConfiguration: IPHStyleConfiguration) {
        if let backgroundColorInfo = styleConfiguration.backgroundColorInfo {
            view.backgroundColor = backgroundColorInfo.color
        }
        
        if let tintColor = styleConfiguration.tintColorInfo {
            view.tintColor = tintColor.color
        }
        
        if supportsBorder() {
            if let borderInfo = styleConfiguration.borderInfo {
                if let borderRadius = borderInfo.cornerRadius {
                    view.layer.masksToBounds = true
                    view.layer.borderColor = borderInfo.borderColorInfo.color.CGColor
                    view.layer.borderWidth = CGFloat(borderInfo.borderLeft.value)
                    view.layer.cornerRadius = CGFloat(borderRadius.value)
                } else {
                    addBorder(borderInfo)
                }
            }
        }
    }
    
    private func addBorder(borderInfo: PHBorderInfo) {
        let borderColor = borderInfo.borderColorInfo.color
        
        if borderInfo.borderLeft.value > 0 {
            let leftBorder = PHBorderLine.borderForView(self.view, color: borderColor, width: borderInfo.borderLeft.value, position: .Left)
            
            if let offset = borderInfo.borderLeftOffset where offset.value > 0 {
                var rect = leftBorder.frame
                rect.origin.x = CGFloat(offset.value)
                leftBorder.frame = rect
            }
            
            self.view.addSubview(leftBorder)
        }
        
        if borderInfo.borderTop.value > 0 {
            let topBorder = PHBorderLine.borderForView(self.view, color: borderColor, width: borderInfo.borderTop.value, position: .Top)
            
            if let offset = borderInfo.borderTopOffset where offset.value > 0 {
                var rect = topBorder.frame
                rect.origin.y = CGFloat(offset.value)
                topBorder.frame = rect
            }
            
            self.view.addSubview(topBorder)
        }
        
        if borderInfo.borderRight.value > 0 {
            let rightBorder = PHBorderLine.borderForView(self.view, color: borderColor, width: borderInfo.borderRight.value, position: .Right)
            
            if let offset = borderInfo.borderRightOffset where offset.value > 0 {
                var rect = rightBorder.frame
                rect.origin.x = rect.width - CGFloat(offset.value)
                rightBorder.frame = rect
            }
            
            self.view.addSubview(rightBorder)
        }
        
        if borderInfo.borderBottom.value > 0 {
            let bottomBorder = PHBorderLine.borderForView(self.view, color: borderColor, width: borderInfo.borderBottom.value, position: .Bottom)
            
            if let offset = borderInfo.borderBottomOffset where offset.value > 0 {
                var rect = bottomBorder.frame
                rect.origin.y = rect.height - CGFloat(offset.value)
                bottomBorder.frame = rect
            }
            
            self.view.addSubview(bottomBorder)
        }
    }
    
    private func removeCurrentBorder() {
        for subview in self.view.subviews {
            if subview.tag == PHBorderLine.borderLineTag {
                subview.removeFromSuperview()
            }
        }
    }
    
    func supportsBorder() -> Bool {
        return true
    }
}