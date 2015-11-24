//
//  PHColorInfo.swift
//  PHCSSTheme
//
//  Created by Sergey on 23.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

public class PHColorInfo {
    private let red: Double
    private let green: Double
    private let blue: Double
    private let alpha: Double
    private static var colorsCache: [String: UIColor] = [:]
    
    public lazy var color: UIColor = {
        let identifier = String(format: "%.4f %.4f %.4f %.1f", self.red, self.green, self.blue, self.alpha)
        
        if let colorModel = PHColorInfo.colorsCache[identifier] {
            return colorModel
        } else {
            let colorModel = UIColor(red: CGFloat(self.red), green: CGFloat(self.green), blue: CGFloat(self.blue), alpha: CGFloat(self.alpha))
            PHColorInfo.colorsCache[identifier] = colorModel
            return colorModel
        }
    }()
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension PHColorInfo: CustomStringConvertible {
    public var description: String {
        return "Hex: \(hexStringRepresentation()), RGBA: \(rgbaStringRepresentation())"
    }
    
    private func hexStringRepresentation() -> String {
        return String(format: "#%02X%02X%02X_%.2f", Int(255 * red), Int(255 * green), Int(255 * blue), self.alpha)
    }
    
    private func rgbaStringRepresentation() -> String {
        return "(\(Int(255 * red)),\(Int(255 * green)),\(Int(255 * blue)),\(alpha))"
    }
}