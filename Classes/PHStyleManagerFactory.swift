//
//  PHStyleManagerFactory.swift
//  PHCSSTheme
//
//  Created by Sergey on 25.11.15.
//  Copyright © 2015 Sergey Plotkin. All rights reserved.
//

import Foundation
import UIKit

class PHStyleManagerFactory {
    class func styleManagerForView(view: UIView) -> IPHStyleManager {
        switch view {
        case let activityIndicator as UIActivityIndicatorView:
            return PHActivityIndicatorStyleManager(view: activityIndicator)
        case let navigationBar as UINavigationBar:
            return PHNavigationBarStyleManager(view: navigationBar)
        case let label as UILabel:
            return PHLabelStyleManager(view: label)
        case let switchView as UISwitch:
            return PHSwitchStyleManager(view: switchView)
        case let textView as UITextView:
            return PHTextViewStyleManager(view: textView)
        case let textField as UITextField:
            return PHTextFieldStyleManager(view: textField)
        case let tabBar as UITabBar:
            return PHTabBarStyleManager(view: tabBar)
        case let segmentedControl as UISegmentedControl:
            return PHSegmentedControlStyleManager(view: segmentedControl)
        default:
            return PHViewStyleManager(view: view)
        }
    }
}