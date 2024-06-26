//
//  MainCoordinator.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.07.2023.
//

import Foundation
import UIKit
import Common
import SignInCoordinator
import TutorRegistrationModule

class MainCoordinator: BaseCoordinator {
    
    private let mainWindow: UIWindowScene
    
    private let router: MainRouter
    
    init(window: UIWindowScene) {
        self.mainWindow = window
        router = MainRouter(windowScene: window)
        super.init()
        bind()
    }
    
    func startCoordinator() {
//        guard isAppOpen else {
//            // TODO: - when Onboarding will be added
//            return
//        }
//
//        guard isUserReg else {
            startSignInFlow()
//            return
//        }
    }

    func startSignInFlow() {
        let coordinator = SignInCoordinator(
            router: router,
            output: self
        )
        let navigationControoler = UINavigationController()
        router.setRootModule(navigationControoler)
        coordinator.startCoordinator()
        addDependency(coordinator)
    }
    
    func startTutorRegistrationFlow() {
        let coordinator = TutorRegistrationCoordinator(
            router: router,
            output: self
        )
        coordinator.startCoordinator()
        addDependency(coordinator)
    }
}

extension MainCoordinator {
    func bind() {
        
    }
}

extension MainCoordinator: SignInCoordinatorOutput {
    func endLogin(is newUser: Bool, type: RegistrationType) {
        if newUser {
            startTutorRegistrationFlow()
        } else {
            
        }
    }
}

extension MainCoordinator: TutorRegistrationCoordinatorOutput {
    
}
    
