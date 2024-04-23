//
//  RegistrationContainer.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 28.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
public enum RegistrationContainer: Hashable {
    case personal(output: PersonalDataModuleOutput? = nil)
    case subjects(output: SubjectsModuleOutput? = nil,model: [String]? = nil)
    case specialization(output: SpecializationModuleOutput? = nil, model: [String]? = nil)
    case meetingsPlace
    case education
    case experience
    case certificate
    case schedule
    case price
    case profile
    
    public var serialNumber: Int {
        switch self {
        case .personal:
            return 0
        case .subjects:
            return 1
        case .specialization:
            return 2
        case .meetingsPlace:
            return 3
        case .education:
            return 4
        case .experience:
            return 5
        case .certificate:
            return 6
        case .schedule:
            return 7
        case .price:
            return 8
        case .profile:
            return 9
        }
    }
    
    public var someMockModels: [String]? {
        switch self {
        case let .specialization(_, model) :
            return model
        case let .subjects(_, model):
            return model
        default:
            return nil
        }
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(serialNumber)
    }

    public static func == (lhs: RegistrationContainer, rhs: RegistrationContainer) -> Bool {
        return lhs.serialNumber == rhs.serialNumber
    }
}
