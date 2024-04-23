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
    case purpleViewData(String)
    case personalData
    case contacts
    case specialization
    
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
        case let .purpleViewData(name):
            return "\(name), добро пожаловать в StudyBuddy!"
        case .personalData:
            return "Личные данные"
        case .contacts:
            return "Контакты"
        case .specialization:
            return "По каким целям готовите учеников?"
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
        case .purpleViewData:
            return "Для продолжения регистрации \nзаполните небольшую анкету"
        case .personalData:
            return "Эта информация нужна для регистрации и проверки анкеты"
        case .contacts:
            return "Никто не будет видеть ваши контакты, нужны для регистрации и для входа в личный кабинет"
        case .specialization:
            return "Расскажите с каким целями вы можете помочь наиболее эффективно, чтобы у вас было больше учеников , которым нужен репетитор именно с таким опытом"
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
