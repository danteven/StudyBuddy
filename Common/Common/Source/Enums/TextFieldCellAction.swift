//
//  TextFieldCellAction.swift
//  Common
//
//  Created by Shamil Mazitov on 30.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

public enum TextfieldCellAction {
    case updateText(String)
    case updateState(TextFieldStateType)
    case becomeFirstResponder
    case resignFirstResponder
}
