//
//  TutorRegistrationCoordinator.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 26.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class TutorRegistrationCoordinator: BaseCoordinator {
    
    private let output: TutorRegistrationCoordinatorOutput
    private let router: Router
    
    public init(
        router: Router,
        output: TutorRegistrationCoordinatorOutput
    ) {
        self.router = router
        self.output = output
    }
    
    public func startCoordinator() {
        let vc = TutorRegistrationConfigurator().configure(output: self)
        router.push(vc)
    }
}

extension TutorRegistrationCoordinator: TutorRegistrationOutput { 
    func onCloseNavigation() {
        router.popModule()
    }
}
