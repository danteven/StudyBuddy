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
    case forgotPassword
    case codeEmail
    case registrationStudent
    case registrationTutor
    
    public var title: String {
        switch self {
        case .codeSignIn:
            return "Введите код из СМС"
        case .forgotPassword:
            return "Забыли пароль?"
        case .codeEmail:
            return "Мы отправили письмо с инструкциями"
        case .registrationStudent:
            return "Регистрация ученика"
        case .registrationTutor:
            return "Регистрация репетитора"
        }
    }
    
    public var subtitle: String {
        switch self {
        case .codeSignIn:
            return "Мы отправили персональный 6-значный код на номер +7 000 000–00–00"
        case .forgotPassword:
            return "Для восстановления пароля введите адрес эл.почты, на который вы регистрировались. Мы отправим письмо для воссталовления пароля"
        case .codeEmail:
            return "Если вы не получили письмо с инструкциями, проверьте, пожалуйста, папку «Спам» или попробуйте отправить запрос ещё раз"
        case .registrationStudent:
            return "Репетиторы не будут видеть ваши контакты, они нужны только для регистрации"
        case .registrationTutor:
            return "Никто не будет видеть твои контакты, они нужны только для регистрации"
        }
    }
    
    public var subtitleColor: UIColor {
        switch self {
        case .codeSignIn, .codeEmail:
            return .black
        default:
            return CommonAsset.Colors.darkGrey.color
        }
    }
    
    public var spacing: CGFloat {
        switch self {
        default:
            return 10
        }
    }
    
    public var titleFont: UIFont {
        switch self {
        case .codeEmail:
            return .boldSystemFont(ofSize: 27)
        default:
            return .boldSystemFont(ofSize: 32)
        }
    }
    
    public var subtitleFont: UIFont {
        switch self {
        default:
            return .systemFont(ofSize: 16)
        }
    }
    
    public var alignment: NSTextAlignment {
        switch self {
        case .codeEmail:
            return .center
        default:
            return .left
        }
    }
}
