//
//  PersonalDataViewModel.swift
//  StudyBuddy
//
//  Created by Shamil on 27/03/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import Combine

final class PersonalDataViewModel {

    // MARK: - Private Properties

    let tableSections = PersonalTableSections.allCases
    let firstModel: [PersonalTextfieldTypes] = [
        .secondName,
        .name,
        .surname,
        .male,
        .date
    ]
    let secondModel: [PersonalTextfieldTypes] = [
        .phone,
        .email
    ]
    
    private var personalDataDict = [PersonalTextfieldTypes: String]()
    private weak var output: PersonalDataModuleOutput?
    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(output: PersonalDataModuleOutput? = nil) {
        self.output = output
        bind()
    }
    
    func setPersonalData(type: PersonalTextfieldTypes, value: String?) {
        personalDataDict[type] = value
        guard personalDataDict.values.contains(where: { $0.isEmpty == true }) || personalDataDict.values.count < 7 else {
            output?.changeState(is: .valid, type: .personal())
            return
        }
        output?.changeState(is: .valid, type: .personal())
    }

}

// MARK: - Private methods

private extension PersonalDataViewModel {

    func bind() {

    }

}




