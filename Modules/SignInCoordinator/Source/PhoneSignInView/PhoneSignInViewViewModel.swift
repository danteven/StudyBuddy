//
//  PhoneSignInViewViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 17/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine
import Common

final class PhoneSignInViewViewModel {
    
    // MARK: - Properties
    
    let tableSections: [SignInTable] = [
        .phone,
        .email
    ]


    // MARK: - Private Properties

    private var output: PhoneSignInViewModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: PhoneSignInViewModuleOutput) {
        self.output = output
        bind()
    }
    
    func buttonAction(type: SignInActionType) {
        switch type {
        case .back:
            break
        case .forgotPassword:
            output.forgotPasswordView()
        case .enter:
            output.enterCodeView()
        case let .registration(type):
            output.registration(type: type)
        }
    }

}

// MARK: - Private methods

private extension PhoneSignInViewViewModel {

    func bind() {

    }

}




