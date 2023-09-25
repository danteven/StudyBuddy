//
//  SBButtonType.swift
//  Common
//
//  Created by Shamil Mazitov on 25.09.2023.
//  Copyright © 2023 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

public enum SBButtonType {
    case border(String)
    case filled(String)
    
    public var title: String {
        switch self {
        case .border(let string):
            return string
        case .filled(let string):
            return string
        }
    }
    
    @available(iOS 15.0, *)
    public var config: UIButton.Configuration {
        switch self {
        case .border(_):
            return .bordered()
        case .filled(_):
            return .filled()
        }
    }
}
