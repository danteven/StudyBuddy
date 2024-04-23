//
//  PhoneSignInViewModuleOutput.swift
//  StudyBuddy
//
//  Created by Shamil on 17/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Common

protocol PhoneSignInViewModuleOutput {

    func enterCodeView()
    
    func forgotPasswordView()
    
    func registration(type: RegistrationType)
    
}




