//
//  SpecializationCellViewModel.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 12.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import Common
import Combine

class SpecializationCellViewModel {
    
    let specModel = [
        "Подготовка к дрочильне",
        "Подготовка к шлюхам",
        "Подготовка к стрипуху",
        "Подготовка к анилингусу",
        "Подготовка к золотому дождю",
    ]
    
    
    // MARK: - Private Properties
    
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init
    
    init() {
        bind()
    }

}

// MARK: - Private methods

private extension SpecializationCellViewModel {

    func bind() {

    }
}
