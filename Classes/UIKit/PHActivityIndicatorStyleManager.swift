//
//  PHActivityIndicatorStyleManager.swift
//  PHCSSTheme
//
//  Created by Sergey on 24.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHActivityIndicatorStyleManager: PHViewStyleManager<UIActivityIndicatorView> {
    override init(view: UIActivityIndicatorView) {
        super.init(view: view)
    }
    
    override func applyStyle(styleConfiguration: IPHStyleConfiguration) {
        super.applyStyle(styleConfiguration)
        
        if let colorInfo = styleConfiguration.colorInfo {
            view.color = colorInfo.color
        }
    }
}