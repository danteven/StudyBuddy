//
//  PhoneSignInViewViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 17/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine

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
    
    func enterCodeView() {
        output.enterCodeView()
    }

}

// MARK: - Private methods

private extension PhoneSignInViewViewModel {

    func bind() {

    }

}




