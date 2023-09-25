//
//  CodeSignInViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 21/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine

final class CodeSignInViewModel {

    // MARK: - Private Properties

    private var output: CodeSignInModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: CodeSignInModuleOutput) {
        self.output = output
        bind()
    }
    
    func back() {
        output.onBack()
    }

}

// MARK: - Private methods

private extension CodeSignInViewModel {

    func bind() {

    }

}




