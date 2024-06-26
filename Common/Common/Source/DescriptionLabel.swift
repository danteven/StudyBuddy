//
//  DescriptionLabel.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit

public class DescriptionLabel: UIView {
    
    private let titleLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    
    private let spacing: CGFloat
    
    
    public init(spacing: CGFloat = 20) {
        self.spacing = spacing
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(type: DescriptionType) {
        titleLabel.text = type.title
        titleLabel.font = type.titleFont
        subtitleLabel.font = type.subtitleFont
        subtitleLabel.textColor = type.subtitleColor
        titleLabel.textAlignment = type.alignment ?? .center
        subtitleLabel.textAlignment = type.alignment ?? .center
        let attString = NSMutableAttributedString(string: type.subtitle)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        attString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attString.length))
        subtitleLabel.attributedText = attString
    }
    
}
private extension DescriptionLabel {
    
    func setup() {
        
        addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .leftR, .topR, .rightR)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = .black

        addSubview(subtitleLabel)
        subtitleLabel.pinToSuperView(sides: .leftR, .rightR, .bottomR)
        subtitleLabel.pin(side: .top(spacing), to: .bottom(titleLabel))
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        
    }
}
