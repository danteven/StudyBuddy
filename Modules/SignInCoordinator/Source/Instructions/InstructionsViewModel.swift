//
//  InstructionsViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 29/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Combine

final class InstructionsViewModel {

    // MARK: - Private Properties

    private var output: InstructionsModuleOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: InstructionsModuleOutput) {
        self.output = output
        bind()
    }
    
    func close() {
        output.close()
    }

}

// MARK: - Private methods

private extension InstructionsViewModel {

    func bind() {

    }

}




