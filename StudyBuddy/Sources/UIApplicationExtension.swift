//
//  UIApplicationExtension.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.09.2023.
//

import Foundation
import UIKit

public extension UIApplication {

    class func topViewController(
        _ controller: UIViewController?) -> UIViewController? {

        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }

        return controller
    }

}
