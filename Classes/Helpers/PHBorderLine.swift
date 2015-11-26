//
//  PHBorderLine.swift
//  PHCSSTheme
//
//  Created by Sergey on 26.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

enum PHBorderLinePosition {
    case Left
    case Top
    case Right
    case Bottom
}

class PHBorderLine: UIView {
    private let color: UIColor
    private let position: PHBorderLinePosition
    private let width: Double
    private var lineLayer: CALayer? {
        willSet {
            if lineLayer != nil {
                lineLayer?.removeFromSuperlayer()
            }
        }
        didSet {
            if let newLayer = lineLayer {
                self.layer.addSublayer(newLayer)
            }
        }
    }
    internal static let borderLineTag = 999
    
    init(frame: CGRect, color: UIColor, position: PHBorderLinePosition, width: Double) {
        self.color = color
        self.position = position
        self.width = width
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect: CGRect
        
        switch position {
        case .Left:
            rect = CGRect(x: 0, y: 0, width: width, height: Double(bounds.height))
        case .Top:
            rect = CGRect(x: 0, y: 0, width: Double(bounds.width), height: width)
        case .Right:
            rect = CGRect(x: ceil(width) - width, y: 0, width: width, height: Double(bounds.height))
        case .Bottom:
            rect = CGRect(x: 0, y: ceil(width) - width, width: Double(bounds.width), height: width)
        }
        
        let path = UIBezierPath(rect: rect)
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.fillColor = color.CGColor
        
        lineLayer = layer
    }
}

extension PHBorderLine {
    class func borderForView(view: UIView, color: UIColor, width: Double, position: PHBorderLinePosition) -> UIView {
        let autoresizingMask: UIViewAutoresizing
        let rect: CGRect
        
        switch position {
        case .Left:
            autoresizingMask = [.FlexibleHeight, .FlexibleRightMargin]
            rect = CGRect(x: 0, y: 0, width: ceil(width), height: Double(view.frame.height))
        case .Top:
            autoresizingMask = [.FlexibleWidth, .FlexibleBottomMargin]
            rect = CGRect(x: 0, y: 0, width: Double(view.frame.width), height: ceil(width))
        case .Right:
            autoresizingMask = [.FlexibleHeight, .FlexibleLeftMargin]
            rect = CGRect(x: Double(view.frame.width) - ceil(width), y: 0, width: ceil(width), height: Double(view.frame.height))
        case .Bottom:
            autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
            rect = CGRect(x: 0, y: Double(view.frame.height) - ceil(width), width: Double(view.frame.width), height: ceil(width))
        }
        
        let borderLine = PHBorderLine(frame: rect, color: color, position: position, width: width)
        borderLine.autoresizingMask = autoresizingMask
        borderLine.tag = borderLineTag
        
        return borderLine
    }
}
