//
//  HeaderButtonType.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit

public enum HeaderButtonType {
    case back
    
    public var image: UIImage {
        switch self {
        case .back:
            return CommonAsset.Buttons.backButton.image
        }
    }
}
