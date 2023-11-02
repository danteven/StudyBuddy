//
//  SignInCollectionEmailCell.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 18.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import Foundation
import UIKit
import Combine
import Common

class SignInCollectionEmailCell: UICollectionViewCell {
    
    enum Constants {
        static let email = "Электронная почта"
        static let emailPlaceholder = "Введите электронную почту"
        static let password = "Пароль"
        static let passwordPlaceholder = "Введите пароль"
        static let forgetPassword = "Забыли пароль?"
        static let enter = "Войти"
    }
    
    public var onActionPublisher: AnyPublisher<SignInActionType, Never> {
        onActionSubject.eraseToAnyPublisher()
    }
    
    private let onActionSubject = PassthroughSubject<SignInActionType, Never>()
            
    private let enterButton = SBButton(
        type: .filled(Constants.enter),
        image: CommonAsset.Buttons.arrow.image
    )
        
    private let emailTextfield = StuddyBuddyTextField(title: Constants.email)
    
    private let passwordTextField = StuddyBuddyTextField(title: Constants.password)
    
    private let forgetPassword = UIButton()
    
    private var cancellableSet = Set<AnyCancellable>()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}

private extension SignInCollectionEmailCell {
    
    func setup() {

        addSubview(emailTextfield)
        emailTextfield.pinToSuperView(sides: .left(16), .right(-16), .top(20))
        emailTextfield.placeholder = Constants.emailPlaceholder
        
        addSubview(passwordTextField)
        passwordTextField.pinToSuperView(sides: .left(16), .right(-16))
        passwordTextField.pin(side: .top(16), to: .bottom(emailTextfield))
        passwordTextField.placeholder = Constants.passwordPlaceholder
        passwordTextField.rightView = UIImageView(image: CommonAsset.Buttons.eyeOff.image)
        
        addSubview(forgetPassword)
        forgetPassword.pinToSuperView(sides: .right(-16))
        forgetPassword.pin(side: .top(12), to: .bottom(passwordTextField))
        forgetPassword.setTitle(Constants.forgetPassword, for: .normal)
        forgetPassword.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
        forgetPassword.titleLabel?.font = .systemFont(ofSize: 14)
        
        addSubview(enterButton)
        enterButton.pinToSuperView(sides: .left(16), .right(-16), .bottomR)
        enterButton.pin(side: .top(60), to: .bottom(passwordTextField))
        enterButton.setDemission(.height(47))
    }
    
    func bind() {
        forgetPassword.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { cell, _ in
                cell.onActionSubject.send(.forgotPassword)
            }
            .store(in: &cancellableSet)
    }
}
