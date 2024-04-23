//
//  SpecializationCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 12.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class SpecializationCell: UICollectionViewCell {
    
    enum Constants {
        static let placeholder = "Например, подготовка к ЕГЭ"
    }

    // MARK: - UICollectionViewCell properties

    // MARK: - Private properties

    private var viewModel = SpecializationCellViewModel()
    private let label = UILabel()
    private let greyView = UIView()
    private let textField = StuddyBuddyTextField()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    public func configure(with title: String) {
        label.text = title
    }
}

// MARK: - Private methods

private extension SpecializationCell {

    func setup() {
        contentView.addSubview(greyView)
        greyView.pinToSuperView(sides: .topR, .left(16), .rightR)
        greyView.setDemission(.height(60))
        greyView.layer.cornerRadius = 15
        greyView.backgroundColor = CommonAsset.Colors.greyLight.color
        
        greyView.addSubview(label)
        label.pinToSuperView(sides: .left(16), .centerYR)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [textField ])
        
    }
}

