//
//  CodeSignInViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 21/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine
import Common

final class CodeSignInViewModel {

    // MARK: - Private Properties

    private let name: String?
    private let type: RegistrationType?
    private var output: CodeSignInModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(
        name: String? = nil,
        type: RegistrationType? = nil,
        output: CodeSignInModuleOutput
    ) {
        self.name = name
        self.type = type
        self.output = output
        bind()
    }
    
    func buttonAction(type: CodeSignInAction) {
        switch type {
        case .back:
            output.onBack()
        case .next:
            output.endLogin(is: true, type: self.type)
        }
    }

}

// MARK: - Private methods

private extension CodeSignInViewModel {

    func bind() {

    }

}




