//
//  PersonalTextfieldTypes.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 30.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

enum PersonalTextfieldTypes: Int, CaseIterable {
    case secondName
    case name
    case surname
    case male
    case date
    case phone
    case email
    
    public var title: String {
        switch self {
        case .secondName:
            return "Фамилия"
        case .name:
            return "Имя"
        case .surname:
            return "Отчество"
        case .male:
            return "Пол"
        case .date:
            return "Дата"
        case .phone:
            return "Телефон"
        case .email:
            return "Электронная почта"
        }
    }
    
    public var placeholder: String {
        switch self {
        case .secondName:
            return "Введите фамилию"
        case .name:
            return "Введите имя"
        case .surname:
            return "Введите отчество"
        case .male:
            return "Пол не выбран"
        case .date:
            return "Дата не указана"
        case .phone:
            return "Введите номер телефона"
        case .email:
            return "Укажите электронную почту"
        }
    }
    
    var isArrowNeeded: Bool {
        switch self {
        default:
            return false
        }
    }
}
