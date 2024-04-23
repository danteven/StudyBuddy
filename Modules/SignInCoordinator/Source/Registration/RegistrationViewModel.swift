//
//  RegistrationViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 12/10/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine
import Common

final class RegistrationViewModel {
    
    // MARK: - Properties
    
    let type: RegistrationType

    // MARK: - Private Properties

    private var output: RegistrationModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(
        type: RegistrationType,
        output: RegistrationModuleOutput
    ) {
        self.type = type
        self.output = output
        bind()
    }
    
    func buttonAction(type: RegistrationButtonActionType) {
        switch type {
        case .back:
            output.back()
        case let .registration(name):
            guard self.type == .tutor else {
                output.enterCode(
                    type: .student,
                    name: nil
                ) 
                return
            }
            output.enterCode(type: self.type, name: name)
        }
    }

}

// MARK: - Private methods

private extension RegistrationViewModel {

    func bind() {

    }

}




