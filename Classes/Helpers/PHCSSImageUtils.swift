//
//  PHCSSImageUtils.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHCSSImageUtils {
    class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return image
    }
    
    class func tintImage(image: UIImage, withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
        
        let context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, .Normal);
        
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        CGContextClipToMask(context, rect, image.CGImage);
        color.setFill()
        CGContextFillRect(context, rect);
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
}