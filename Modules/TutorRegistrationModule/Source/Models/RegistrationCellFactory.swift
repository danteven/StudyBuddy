//
//  RegistrationCellFactory.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 28.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

public struct RegistrationCellFactory {
    public static func getView(for model: RegistrationCellModel) -> UIView {
        switch model.type {
        case let .personal(output):
            return PersonalDataConfigurator().configure(output: output)
        case let .subjects(output, model):
            return SubjectsConfigurator().configure(output: output)
        case let .specialization(output, model):
            return SpecializationConfigurator().configure(
                model: model,
                output: output
            )
        default: return UIView()
        }
    }
}
