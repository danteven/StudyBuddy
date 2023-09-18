//
//  SignInTable.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 17.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation

public enum SignInTable {
    case phone
    case email
    
    var title: String {
        switch self {
        case .phone:
            return "Номер телефона"
        case .email:
            return "Эл. почта"
        }
    }
    var subtitle: String {
        switch self {
        case .phone:
            return "Мы отправим персональный 6-значный код для входа в личный кабинет"
        case .email:
            return ""
        }
    }
}
