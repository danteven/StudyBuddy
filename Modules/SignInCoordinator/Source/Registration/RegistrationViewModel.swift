//
//  RegistrationViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 12/10/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine

final class RegistrationViewModel {

    // MARK: - Private Properties

    private var output: RegistrationModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: RegistrationModuleOutput) {
        self.output = output
        bind()
    }

}

// MARK: - Private methods

private extension RegistrationViewModel {

    func bind() {

    }

}




