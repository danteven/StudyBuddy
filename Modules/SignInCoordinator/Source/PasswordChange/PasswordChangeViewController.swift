//
//  PasswordChangeViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 26/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class PasswordChangeViewController: UIViewController {

    enum Constants {
        static let email = "Электронная почта"
        static let enterEmail = "Введите электронную почту"
        static let send = "Отправить"
    }

    // MARK: - Private Properties

    
    private lazy var headerView = LogoHeaderView(.icon, leftButton: leftButton)
    
    private let textfield = StuddyBuddyTextField(title: Constants.email)
        
    private let button = SBButton(type: .filled(Constants.send))
    
    private let descriptionLabel = DescriptionLabel(spacing: 20)
    
    private let leftButton = HeaderButton(type: .back)
    private let viewModel: PasswordChangeViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: PasswordChangeViewModel) {
	self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController methods

    override func loadView() {
        super.loadView()
        setup()
    }

}

// MARK: - Private methods

private extension PasswordChangeViewController {

    func setup() {
        view.backgroundColor = .white
        
        headerView.addHeader(to: view)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16))
        descriptionLabel.pin(side: .top(30), to: .bottom(headerView))
        descriptionLabel.configure(type: .forgotPassword)
        
        view.addSubview(textfield)
        textfield.pinToSuperView(sides: .left(16), .right(-16))
        textfield.pin(side: .top(20), to: .bottom(descriptionLabel))
        textfield.placeholder = Constants.enterEmail
        
        view.addSubview(button)
        button.pinToSuperView(sides: .left(16), .right(-16))
        button.pin(side: .top(40), to: .bottom(textfield))
        button.setDemission(.height(47))
        
    }

    func bind() {
        leftButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.back()
            }
            .store(in: &cancellableSet)
        
        button.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.showInstruction()
            }
            .store(in: &cancellableSet)
    }

}
