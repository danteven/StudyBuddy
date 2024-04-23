//
//  SpecializationViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 11/04/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import Combine

final class SpecializationViewModel {
    
    let model: [String]?
    
    let subjectsModel = [
        "подготовка к ЕГЭ",
        "подготовка к ОГЭ",
        "подготовка к сосанию члена",
        "подготовка к шлангу Арефа"
    ]

    // MARK: - Private Properties

    private var output: SpecializationModuleOutput?
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(
        model: [String]?,
         output: SpecializationModuleOutput?
    ) {
        self.model = model
        self.output = output
        bind()
    }

}

// MARK: - Private methods

private extension SpecializationViewModel {

    func bind() {

    }

}




