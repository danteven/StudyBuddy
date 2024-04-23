//
//  SignInCoordinatorOutput.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 26.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

public protocol SignInCoordinatorOutput: AnyObject {
    func endLogin(is newUser: Bool, type: RegistrationType?)
}
