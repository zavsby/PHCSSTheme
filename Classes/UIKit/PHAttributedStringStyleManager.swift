//
//  PHAttributedStringStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 25.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHAttributedStringStyleManager {
    private let attributedString: NSMutableAttributedString
    
    init(attributedString: NSMutableAttributedString) {
        self.attributedString = attributedString
    }
    
    func applyStyle(styleConfiguration: IPHStyleConfiguration, range: Range<Int>) {
        let nsrange = NSRange(location: range.startIndex, length: range.endIndex - range.startIndex)
        
        if let fontInfo = styleConfiguration.fontInfo {
            attributedString.addAttribute(NSFontAttributeName, value: fontInfo.font, range: nsrange)
        }
        
        if let textColorInfo = styleConfiguration.textColorInfo {
            attributedString.addAttribute(NSForegroundColorAttributeName, value: textColorInfo.color, range: nsrange)
        }
        
        if let underlineStyle = styleConfiguration.underlineStyle {
            attributedString.addAttribute(NSUnderlineStyleAttributeName, value: underlineStyle.rawValue, range: nsrange)
        }
        
        if let textAlignment = styleConfiguration.textAlignmentInfo {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment.textAlignment
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: nsrange)
        }
    }
}