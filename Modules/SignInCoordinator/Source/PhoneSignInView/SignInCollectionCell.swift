//
//  SignInCollectionCell.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 17.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit

class SignInCollectionCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with type: SignInTable) {
        
    }
    
}

private extension SignInCollectionCell {
    
    func setup() {
        addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .centerXR, .centerXR)
        titleLabel.font = .systemFont(ofSize: 16)
//        addSubview(descriptionLabel)
//        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16), .topR)
//        descriptionLabel.textColor = SignInCoordinatorAsset.Colors.darkGrey.color
//        descriptionLabel.font = .systemFont(ofSize: 14)
//
//        addSubview(subtitleLabel)
//        subtitleLabel.pinToSuperView(sides: .left(16))
//        subtitleLabel.pin(side: .top(20), to: .bottom(descriptionLabel))
//        subtitleLabel.font = .systemFont(ofSize: 14)
    }
    
    func bind() {
        
    }
}
