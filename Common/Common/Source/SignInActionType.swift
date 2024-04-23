//
//  SignInActionType.swift
//  Common
//
//  Created by Shamil Mazitov on 26.09.2023.
//  Copyright © 2023 StuddyBuddy. All rights reserved.
//

import Foundation
import Common

public enum SignInActionType {
    case back
    case forgotPassword
    case enter
    case registration(RegistrationType)
}
