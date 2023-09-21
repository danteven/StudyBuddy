//
//  SignInCollectionCell.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 18.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit

class SignInCollectionPhoneCell: UICollectionViewCell {
    
    enum Constants {
        static let description = "Мы отправим персональный 6-значный код для входа в личный кабинет"
        static let phone = "Номер телефона"
    }
    
    private let descriptionLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    
    private let phoneTextfield = StuddyBuddyTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        descriptionLabel.text = text
    }
    
}

private extension SignInCollectionPhoneCell {
    
    func setup() {
       
        addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16), .top(10))
        descriptionLabel.textColor = SignInCoordinatorAsset.Colors.darkGrey.color
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        let attString = NSMutableAttributedString(string: Constants.description)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        attString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attString.length))
        descriptionLabel.attributedText = attString
        
        addSubview(subtitleLabel)
        subtitleLabel.pinToSuperView(sides: .left(16))
        subtitleLabel.pin(side: .top(20), to: .bottom(descriptionLabel))
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.text = Constants.phone
        
        addSubview(phoneTextfield)
        phoneTextfield.pinToSuperView(sides: .left(16), .right(-16), .bottomR)
        phoneTextfield.pin(side: .top(8), to: .bottom(subtitleLabel))
        phoneTextfield.setView(image: SignInCoordinatorAsset.flag.image, side: .left, frameView: CGRect(x: 0, y: 0, width: 24, height: 30), frameContainer: CGRect(x: 0, y: 0, width: 32, height: 30))
        phoneTextfield.placeholder = "+7 000 000-00-00"
        
    }
    
    func bind() {
        
    }
}
