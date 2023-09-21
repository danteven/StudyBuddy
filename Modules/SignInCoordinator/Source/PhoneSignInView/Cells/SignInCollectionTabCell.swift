//
//  SignInCollectionCell.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 17.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit

class SignInCollectionTabCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    private let line = UIView()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ?
            .black :
            SignInCoordinatorAsset.Colors.grey.color
            
            line.backgroundColor = isSelected ?
            SignInCoordinatorAsset.Colors.mainPurple.color :
            .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with type: SignInTable) {
        titleLabel.text = type.title
    }
    
}

private extension SignInCollectionTabCell {
    
    func setup() {
        addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .topR, .rightR, .leftR)
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = SignInCoordinatorAsset.Colors.grey.color
        
        addSubview(line)
        line.pinToSuperView(sides: .bottomR)
        line.pin(sides: [.leftR, .rightR], toSameSidesOn: titleLabel)
        line.pin(side: .top(4), to: .bottom(titleLabel))
        line.setDemission(.height(2))
        line.layer.cornerRadius = 5
    }
    
    func bind() {
        
    }
}
