//
//  PHFontInfo.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public struct PHFontInfo {
    private let fontName: String
    private let fontSize: Double
    private static var fontsCache: [String: UIFont] = [:]
    
    public lazy var font: UIFont = {
        let identifier = "\(self.fontName) \(String(format: "%.2f", self.fontSize))"
        
        if let fontModel = PHFontInfo.fontsCache[identifier] {
            return fontModel
        } else if let fontModel = UIFont(name: self.fontName, size: CGFloat(self.fontSize)) {
            PHFontInfo.fontsCache[identifier] = fontModel
            return fontModel
        } else {
            print("Could not load font with name \(self.fontName) and size \(self.fontSize)")
            
            return UIFont.systemFontOfSize(UIFont.systemFontSize())
        }
    }()
    
    public init(fontName: String, fontSize: Double = 17.0) {
        self.fontName = fontName
        self.fontSize = fontSize
    }
    
    public static func showFontList() {
        for fontFamily in UIFont.familyNames() {
            print("Family name: \(fontFamily)")
            for font in UIFont.fontNamesForFamilyName(fontFamily) {
                print("Font name: \(font)")
            }
        }
    }
}

extension PHFontInfo: CustomStringConvertible {
    public var description: String {
        return "Font: \(fontName) \(fontSize)"
    }
}