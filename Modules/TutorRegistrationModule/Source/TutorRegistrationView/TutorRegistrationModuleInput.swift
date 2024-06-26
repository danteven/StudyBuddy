//
//  TutorRegistrationModuleInput.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 01.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

public protocol TutorRegistrationModuleInput {
    func changeState(is valid: RegistrationButtonState, type: RegistrationContainer)
}
