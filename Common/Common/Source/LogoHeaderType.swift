//
//  LogoHeaderType.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit

public enum LogoHeaderType {
    case icon
    
    public var sbIcon: UIImage {
        switch self {
        case .icon:
            return CommonAsset.logoSB.image
        }
    }
}
