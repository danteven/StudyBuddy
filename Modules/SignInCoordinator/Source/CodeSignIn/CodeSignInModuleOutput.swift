//
//  CodeSignInModuleOutput.swift
//  StudyBuddy
//
//  Created by Shamil on 21/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import Common

protocol CodeSignInModuleOutput {

    func onBack()
    
    func endLogin(is newUser: Bool, type: RegistrationType?)
    
}




