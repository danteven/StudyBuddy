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
    
    private let output: SignInCoordinatorOutput
    private let router: Router
    
    public init(
        router: Router,
        output: SignInCoordinatorOutput
    ) {
        self.router = router
        self.output = output
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
    
    func registration(type: RegistrationType) {
        let vc = RegistrationConfigurator().configure(
            type: type,
            output: self
        )
        router.push(vc, animated: true)
    }
}

extension SignInCoordinator: CodeSignInModuleOutput {
    
    func endLogin(is newUser: Bool, type: RegistrationType?) {
        output.endLogin(is: newUser, type: type ?? .tutor)
    }
    
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

extension SignInCoordinator: RegistrationModuleOutput {
    
    func enterCode(type: RegistrationType, name: String? = nil) {
        let vc = CodeSignInConfigurator().configure(
            name: name,
            type: type,
            output: self
        )
        router.push(vc, animated: true)
    }
    
    func backFromRegistration() {
        router.popModule()
    }
}
