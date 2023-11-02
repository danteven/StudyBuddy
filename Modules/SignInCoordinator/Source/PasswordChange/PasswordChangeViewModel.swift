//
//  PasswordChangeViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 26/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine

final class PasswordChangeViewModel {

    // MARK: - Private Properties

    private var output: PasswordChangeModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: PasswordChangeModuleOutput) {
        self.output = output
        bind()
    }
    
    func back() {
        output.back()
    }
    
    func showInstruction() {
        output.showInstruction()
    }

}

// MARK: - Private methods

private extension PasswordChangeViewModel {

    func bind() {

    }

}




