//
//  RegistrationButtonState.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 01.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

public enum RegistrationButtonState {
    case valid
    case invalid
    case customValid(String)
    case customInvalid(String)

    // MARK: - Init

    init(
        is valid: Bool,
        customValid: String? = nil
    ) {
        switch (valid, customValid) {
        case (true, nil):
            self = .valid
        case (false, nil):
            self = .invalid
        case let (true, .some(text)):
            self = .customValid(text)
        case let (false, .some(text)):
            self = .customInvalid(text)
        }
    }

    // MARK: - Public methods

    public var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .customValid(_):
            return true
        case .invalid:
            return false
        case .customInvalid(_):
            return false
        }
    }
}
