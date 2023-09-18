//
//  Presentable.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.09.2023.
//

import Foundation
import UIKit

/// Describes object that can be presented in view hierarchy
public protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    public func toPresent() -> UIViewController? {
        return self
    }

}

extension UIViewController: UIDocumentInteractionControllerDelegate {

    // swiftlint:disable:next line_length
    open func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        self
    }

}
