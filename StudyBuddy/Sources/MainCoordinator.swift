//
//  MainCoordinator.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.07.2023.
//

import Foundation
import UIKit
import SignInCoordinator

class MainCoordinator: BaseCoordinator {
    
    private let mainWindow: UIWindow
    
    init(window: UIWindow) {
        self.mainWindow = window
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
        SignInCoordinator().startCoordinator(from: mainWindow)
    }
}

extension MainCoordinator {
    func bind() {
        
    }
}
    
