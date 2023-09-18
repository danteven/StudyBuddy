//
//  SignInCoordinator.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 17.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit
import UIKit

public class SignInCoordinator {

    public init() { }
    
    public func startCoordinator(from window: UIWindow) {
        let vc = PhoneSignInViewConfigurator().configure(output: self)
        vc.view.backgroundColor = .white

        let navigationControoler = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationControoler
        window.makeKeyAndVisible()
    }
}
extension SignInCoordinator: PhoneSignInViewModuleOutput { }
