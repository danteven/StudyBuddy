//
//  DescriptionType.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit

public enum DescriptionType {
    case codeSignIn
    
    public var title: String {
        switch self {
        case .codeSignIn:
            return "Введите код из СМС"
        }
    }
    
    public var subtitle: String {
        switch self {
        case .codeSignIn:
            return "Мы отправили персональный 6-значный код на номер +7 000 000–00–00"
        }
    }
    
    public var subtitleColor: UIColor {
        switch self {
        case .codeSignIn:
            return .black
        }
    }
    
    public var spacing: CGFloat {
        switch self {
        case .codeSignIn:
            return 10
        }
    }
}
