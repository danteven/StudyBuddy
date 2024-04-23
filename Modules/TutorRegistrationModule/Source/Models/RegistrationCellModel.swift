//
//  RegistrationCellModel.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 28.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
public struct RegistrationCellModel {
    public var type: RegistrationContainer
    
    public init(
        type: RegistrationContainer
    ) {
        self.type = type
    }
}
