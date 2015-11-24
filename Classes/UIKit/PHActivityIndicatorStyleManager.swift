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
    override func applyStyle(styleConfiguration: IPHStyleConfiguration, toView view: UIActivityIndicatorView) {
        super.applyStyle(styleConfiguration, toView: view)
        
        if let colorInfo = styleConfiguration.colorInfo {
            view.color = colorInfo.color
        }
    }
}