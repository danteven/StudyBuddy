//
//  PersonalDataHeader.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 29.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class PersonalDataHeader: UICollectionReusableView {
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    
    // MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func configure(text: String, subtitle: String) {
        titleLabel.text = text
        subtitleLabel.text = subtitle
    }
}

// MARK: - Private methods

private extension PersonalDataHeader {
    
    func setup() {
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: [.left(16), .topR])
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        addSubview(subtitleLabel)
        subtitleLabel.pinToSuperView(sides: [.left(16), .bottomR, .right(-16)])
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textColor = CommonAsset.Colors.grey.color
    }
}
