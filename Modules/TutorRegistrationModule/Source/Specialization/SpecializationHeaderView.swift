//
//  SpecializationHeaderView.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 11.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class SpecializationHeaderView: UICollectionReusableView {
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    
    
    // MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func configure(text: String) {
        titleLabel.text = text
    }
}

// MARK: - Private methods

private extension SpecializationHeaderView {
    
    func setup() {
        backgroundColor = CommonAsset.Colors.greyLight.color
        layer.cornerRadius = 15
        addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: [.left(16), .top(16), .bottom(-16)])
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .black
    }
}
