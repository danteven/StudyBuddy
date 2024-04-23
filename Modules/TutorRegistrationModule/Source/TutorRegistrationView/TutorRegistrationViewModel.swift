//
//  TutorRegistrationViewModel.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import Combine

final class TutorRegistrationViewModel {
    
    var stepIsValid = [RegistrationContainer: RegistrationButtonState]()
    
    var currentStep = 0

    var stepModule: [RegistrationCellModel] { cellModels() }
    
    var onCurrentStepPublisher: AnyPublisher<Int, Never> {
        onCurrentStepSubject.eraseToAnyPublisher()
    }
    
     let model = [
        ["1" : "Личные данные"],
        ["2" : "Предметы"],
        ["3" : "Специализация"],
        ["4" : "Место занятий"],
        ["5" : "Образование"],
        ["6" : "Опыт"],
        ["7" : "Сертификаты"],
        ["8" : "Расписание"],
        ["9" : "Стоимость"],
        ["10" : "Профиль"]
    ]
    
    var onNextButtonStatePublisher: AnyPublisher<(RegistrationButtonState, RegistrationContainer), Never> {
        onNextButtonStateSubject.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let onCurrentStepSubject = PassthroughSubject<Int, Never>()
    private let onNextButtonStateSubject = PassthroughSubject<(RegistrationButtonState, RegistrationContainer), Never>()
    private var someModels = [RegistrationContainer: [String]]()
    private var output: TutorRegistrationOutput
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: TutorRegistrationOutput) {
        self.output = output
        bind()
    }
    
    func viewDidAppear() {
        onCurrentStepSubject.send(currentStep)
    }
    
    func cellModels() -> [RegistrationCellModel] {
        [
            personalDataModel(),
            subjectsDataModel(),
            speciaziationDataModel(model: someModels[.subjects()] ?? []) ///FIXME
        ]
    }
    
    func backAction() {
        guard self.currentStep > 0 else {
            output.onCloseNavigation()
            return
        }
        self.currentStep -= 1
    }

    func nextAction() {
        guard self.currentStep < self.stepModule.count - 1 else {
            return
        }

        self.currentStep += 1
    }
    
    func buttonAction(of type: RegistrationButtonActionType ) {
        let currentType = self.stepModule[self.currentStep].type
        switch type {
        case .back:
            backAction()
        case .next:
            nextAction()
        }
        
        let newType = self.stepModule[self.currentStep].type
        self.onNextButtonStateSubject.send((self.stepIsValid[newType] ?? .invalid, newType))
        self.onCurrentStepSubject.send(self.currentStep)

    }

}

// MARK: - Private methods

private extension TutorRegistrationViewModel {

    func bind() {

    }
    
    private func personalDataModel() -> RegistrationCellModel {
        return RegistrationCellModel(type: .personal(output: self))
    }
    
    private func subjectsDataModel() -> RegistrationCellModel {
        return RegistrationCellModel(type: .subjects(output: self))
    }
    
    private func speciaziationDataModel(model: [String]) -> RegistrationCellModel {
        return RegistrationCellModel(type: .specialization(output: self, model: model))
    }

}

extension TutorRegistrationViewModel: TutorRegistrationModuleInput {
    func changeState(is valid: RegistrationButtonState, type: RegistrationContainer) {
        stepIsValid[type] = valid
        onNextButtonStateSubject.send((valid, type))
        someModels[type] = type.someMockModels
    }
}

extension TutorRegistrationViewModel: PersonalDataModuleOutput { }

extension TutorRegistrationViewModel: SubjectsModuleOutput { }

extension TutorRegistrationViewModel: SpecializationModuleOutput { }
