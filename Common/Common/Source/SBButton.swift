//
//  SBButton.swift
//  Common
//
//  Created by Shamil Mazitov on 25.09.2023.
//  Copyright © 2023 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

public class SBButton: UIButton {
        
    private let type: SBButtonType
    
    public init(type: SBButtonType, image: UIImage? = nil) {
        self.type = type
        super.init(frame: .zero)
        setup(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SBButton {
    func setup(image: UIImage?) {
        if #available(iOS 15, *) {
            var filled = type.config
            var container = AttributeContainer()
            container.font = .systemFont(ofSize: 16)
            filled.attributedTitle = AttributedString(type.title, attributes: container)
            filled.imagePadding = 8
            filled.imagePlacement = .trailing
            filled.image = image
            filled.baseBackgroundColor = CommonAsset.Colors.mainPurple.color
            filled.background.cornerRadius = 23
            configuration = filled
        } else {
            layer.cornerRadius = 23
            backgroundColor = CommonAsset.Colors.mainPurple.color
            setTitle(type.title, for: .normal)
            setTitleColor(.white, for: .normal)
            setImage(CommonAsset.Buttons.arrow.image, for: .normal)
            titleLabel?.textAlignment = .center
            semanticContentAttribute = .forceRightToLeft
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
    }
    
    func bind() {
        
    }
}
