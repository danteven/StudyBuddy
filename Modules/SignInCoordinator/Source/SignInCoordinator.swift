//
//  SignInCoordinator.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 17.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit
import Common

public class SignInCoordinator: BaseCoordinator {
    
    private let router: Router
    
    public init(router: Router) {
        self.router = router
    }
    
    public func startCoordinator() {
        let vc = PhoneSignInViewConfigurator().configure(output: self)
        vc.view.backgroundColor = .white
//        router.setRootModule(vc)
        router.setNavigationControllerRootModule(vc, animated: true, hideBar: true)
    }
}
extension SignInCoordinator: PhoneSignInViewModuleOutput {
    func enterCodeView() {
        let vc = CodeSignInConfigurator().configure(output: self)
        router.push(vc, animated: true)
    }
    
    func forgotPasswordView() {
        let vc = PasswordChangeConfigurator().configure(output: self)
        router.push(vc, animated: true)
    }
    
    func registerStudent() {
        let vc = RegistrationConfigurator().configure(output: self)
        router.push(vc, animated: true)
    }
}

extension SignInCoordinator: CodeSignInModuleOutput {
    
    func onBack() {
        router.popModule()
    }
}

extension SignInCoordinator: PasswordChangeModuleOutput {
    
    func showInstruction() {
        let vc = InstructionsConfigurator().configure(output: self)
        router.present(vc)
    }
    
    func back() {
        router.popModule()
    }
}

extension SignInCoordinator: InstructionsModuleOutput {
    
    func close() {
        router.dismissModule()
    }
}

extension SignInCoordinator: RegistrationModuleOutput { }
