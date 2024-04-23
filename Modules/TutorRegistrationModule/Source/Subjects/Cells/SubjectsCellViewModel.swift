//
//  SubjectsCellViewModel.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 05.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import Combine
import Common

class SubjectsCellViewModel {
    
    var updateMOdelPublisher: CustomPublisher<[String]> {
        updateModelSubject.eraseToAnyPublisher()
    }
    
    let model: [String]
    
    var addedItems = Set<String>()
    
    // MARK: - Private Properties

    private let updateModelSubject = CustomSubject<[String]>()
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(model: [String]) {
        self.model = model
        bind()
    }
    
    func search(text: String) {
        Task(priority: .high) { [weak self] in
            guard let self else { return }
            let updText = text
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
            
            let filter: (String?) -> Bool = { subject in
                
                guard let subject else { return false }
                
                return subject
                    .lowercased()
                    .contains(updText)
            }
            let model = model.compactMap{
                if filter($0) {
                    return $0
                } else {
                    return nil
                }
            }
            updateModelSubject.send(model)
        }
    }

}

// MARK: - Private methods

private extension SubjectsCellViewModel {

    func bind() {

    }
}
