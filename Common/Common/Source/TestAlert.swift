//
//  TestAlert.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.09.2023.
//

import Foundation
import UIKit

public extension UIViewController {
    func showSimpleAlert(title: String, _ cancelAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .cancel,
                handler: cancelAction
            )
        )
        present(alert, animated: true)
    }

    func showMockAlert(title: String) {
        let alert = UIAlertController(title: "MOCK " + title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}
