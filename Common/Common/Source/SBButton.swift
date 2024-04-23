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
    private let needArrow: Bool?
    
    public init(
        type: SBButtonType,
        needArrow: Bool? = nil
//        image: UIImage? = nil,
//        color: UIColor? = nil,
//        cornerRadius: CGFloat,
//        font: UIFont
    ) {
        self.needArrow = needArrow
        self.type = type
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setStyle(enabled: Bool) {
        self.isEnabled = enabled
        self.backgroundColor = enabled ? CommonAsset.Colors.mainPurple.color : CommonAsset.Colors.disabledButton.color

    }
}

private extension SBButton {
    func setup() {
        layer.cornerRadius = 24
        backgroundColor = CommonAsset.Colors.mainPurple.color
        setTitleColor(.white, for: .normal)
        titleLabel?.textAlignment = .center
        setTitle(type.title, for: .normal)
        guard needArrow != nil,
        needArrow == true else { return }
        setImage(CommonAsset.Buttons.arrow.image, for: .normal)
        titleLabel?.textAlignment = .center
        semanticContentAttribute = .forceRightToLeft
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
//    func setup(image: UIImage?, color: UIColor?, cornerRadius: CGFloat, font: UIFont) {
//        if #available(iOS 15, *) {
//            var filled = type.config
//            guard let text = type.title else {
//                filled.imagePlacement = .all
//                filled.image = image
//                filled.baseBackgroundColor = color == nil ? CommonAsset.Colors.mainPurple.color : color
//                filled.background.cornerRadius = cornerRadius
//                configuration = filled
//                return
//            }
//                var container = AttributeContainer()
//                container.font = font
//                filled.attributedTitle = AttributedString(text, attributes: container)
//                filled.imagePadding = 8
//                filled.imagePlacement = .trailing
//                filled.image = image
//                filled.baseBackgroundColor = color == nil ? CommonAsset.Colors.mainPurple.color : color
//                filled.background.cornerRadius = cornerRadius
//                configuration = filled
//        } else {
//            guard let text = type.title else {
//                layer.cornerRadius = cornerRadius
//                backgroundColor = color == nil ? CommonAsset.Colors.mainPurple.color : color
//                setImage(image, for: .normal)
//                imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
//                return
//            }
//                layer.cornerRadius = cornerRadius
//                backgroundColor = color == nil ? CommonAsset.Colors.mainPurple.color : color
//                setTitle(text, for: .normal)
//                setTitleColor(.white, for: .normal)
//                setImage(image, for: .normal)
//                titleLabel?.textAlignment = .center
//                semanticContentAttribute = .forceRightToLeft
//                imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
//        }
//    }
    
    func bind() {
        
    }
}
