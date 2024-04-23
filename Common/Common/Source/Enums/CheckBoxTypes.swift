//
//  CheckBoxTypes.swift
//  Common
//
//  Created by Shamil Mazitov on 04.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

public enum CheckBoxTypes: CaseIterable {
    case pupil
    case student
    case adult
    
    public var title: String {
        switch self {
        case .pupil:
            return "Школьники"
        case .student:
            return "Студенты"
        case .adult:
            return "Взрослые"
        }
    }
}
