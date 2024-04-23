//
//  SubjectsViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 04/04/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import Combine
import Common

final class SubjectsViewModel {
    
    let model = [
       "Математика",
       "Макроэкономика",
       "Микроэкономика",
       "Микропенис",
       "Сифилисный дед",
       "Хуй в говне",
       "Твоя мать шаболда",
       "Жопный спид",
       "Угандонский негр",
       "Вонючий Анус",
       "Дряблый пенис"
   ]
        
    // MARK: - Private Properties
    
    private var addedCategory = Set<CheckBoxTypes>()
    private var addedSubjects = Set<String>()
    private weak var output: SubjectsModuleOutput?
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(
        output: SubjectsModuleOutput?
    ) {
        self.output = output
        bind()
    }
    
    func tappedCategory(type: CheckBoxTypes, isSelected: Bool) {
        guard isSelected else {
            addedCategory.remove(type)
            checkForState()
            return
        }
        addedCategory.insert(type)
        checkForState()
    }
    
    func changeSubjects(type: SubjectsCellAction) {
        switch type {
        case .delete(let string):
            addedSubjects.remove(string)
        case .add(let string):
            addedSubjects.insert(string)
        }
        checkForState()
    }

}

// MARK: - Private methods

private extension SubjectsViewModel {

    func bind() {

    }
    
    func checkForState() {
        guard !addedCategory.isEmpty && !addedSubjects.isEmpty else {
            output?.changeState(is: .invalid, type: .subjects())
            return
        }
        output?.changeState(is: .valid, type: .subjects(model: addedSubjects.compactMap{ $0 }))
    }

}




