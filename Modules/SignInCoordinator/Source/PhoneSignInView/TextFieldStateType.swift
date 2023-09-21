//
//  TextFieldStateType.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 20.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation

public enum TextFieldStateType {
    case plain
    case error(String?)
    case custom(String?)

    // MARK: - Public properties
    
    public var isValid: Bool {
        switch self {
        case .error :
            return false
        case .plain :
            return true
        case .custom :
            return true
        }
    }
    
    public var message: String? {
        switch self {
        case .plain:
            return nil
        case .error(let errorMessage):
            return errorMessage
        case .custom(let customMessage):
            return customMessage
        }
    }
}
