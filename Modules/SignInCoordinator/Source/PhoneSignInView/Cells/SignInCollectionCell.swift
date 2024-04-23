//
//  SignInCollectionCell.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 18.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit
import Combine
import Common

class SignInCollectionPhoneCell: UICollectionViewCell {
    
    enum Constants {
        static let description = "Мы отправим персональный 6-значный код для входа в личный кабинет"
        static let phone = "Номер телефона"
        static let enter = "Войти"
    }
    
    public var onActionPublisher: AnyPublisher<SignInActionType, Never> {
        onActionSubject.eraseToAnyPublisher()
    }
    
    private let onActionSubject = PassthroughSubject<SignInActionType, Never>()
    
    private let descriptionLabel = UILabel()
    
    private let enterButton = SBButton(type: .filled(Constants.enter))
        
    private let phoneTextfield = StuddyBuddyTextField(title: Constants.phone)
    
    private var cancellableSet = Set<AnyCancellable>()

    
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
        descriptionLabel.textColor = CommonAsset.Colors.darkGrey.color
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        let attString = NSMutableAttributedString(string: Constants.description)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        attString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attString.length))
        descriptionLabel.attributedText = attString
                
        addSubview(phoneTextfield)
        phoneTextfield.pinToSuperView(sides: .left(16), .right(-16))
        phoneTextfield.pin(side: .top(20), to: .bottom(descriptionLabel))
        phoneTextfield.setView(image: CommonAsset.flag.image, side: .left, frameView: CGRect(x: 0, y: 0, width: 24, height: 30), frameContainer: CGRect(x: 0, y: 0, width: 32, height: 30))
        phoneTextfield.placeholder = "+7 000 000-00-00"
        
        addSubview(enterButton)
        enterButton.pinToSuperView(sides: .left(16), .right(-16), .bottomR)
        enterButton.pin(side: .top(40), to: .bottom(phoneTextfield))
        enterButton.setDemission(.height(47))
        
    }
    
    func bind() {
        enterButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { cell, _ in
                cell.onActionSubject.send(.enter)
            }
            .store(in: &cancellableSet)
    }
}
