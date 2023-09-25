//
//  FilledButton.swift
//  Common
//
//  Created by Shamil Mazitov on 23.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit

public class FilledButton: UIButton {
    
    public init(color: UIColor, text: String, imagePadding: CGFloat, image: UIImage, radius: CGFloat = 23, font: CGFloat = 16) {        super.init(frame: .zero)
        setup(color: color, text: text, imagePadding: imagePadding, image: image, radius: radius, font: font)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
private extension FilledButton {
    
    func setup(color: UIColor, text: String, imagePadding: CGFloat, image: UIImage, radius: CGFloat, font: CGFloat) {
        if #available(iOS 15, *) {
            var filled = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .systemFont(ofSize: font)
            filled.attributedTitle = AttributedString(text, attributes: container)
            filled.imagePadding = imagePadding
            filled.imagePlacement = .trailing
            filled.image = image
            filled.baseBackgroundColor = color
            filled.background.cornerRadius = radius
            configuration = filled
        } else {
            layer.cornerRadius = radius
            backgroundColor = color
            setTitle(text, for: .normal)
            setTitleColor(.white, for: .normal)
            setImage(image, for: .normal)
            titleLabel?.textAlignment = .center
            semanticContentAttribute = .forceRightToLeft
            imageEdgeInsets = UIEdgeInsets(top: 0, left: imagePadding, bottom: 0, right: 0)
            titleLabel?.font = .systemFont(ofSize: font)
        }
    }
}
