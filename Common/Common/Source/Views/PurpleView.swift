//
//  PurpleView.swift
//  Common
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

public class PurpleView: UIView {

    // MARK: - Private properties

    private let titleLabel = UILabel()
    
    private let subtitleLabel = UILabel()

    // MARK: - Init

    public init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(type: DescriptionType) {
        titleLabel.text = type.title
        subtitleLabel.text = type.subtitle
    }
}

// MARK: - Private Methods

private extension PurpleView {
    func setup() {
        backgroundColor = CommonAsset.Colors.mainPurple.color
        
        addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .left(16), .right(-16), .top(16))
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        addSubview(subtitleLabel)
        subtitleLabel.pinToSuperView(sides: .left(16), .right(-16), .bottom(-16))
        subtitleLabel.pin(side: .top(16), to: .bottom(titleLabel))
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
    }
}

