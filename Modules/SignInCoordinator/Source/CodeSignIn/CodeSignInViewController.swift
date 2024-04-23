//
//  CodeSignInViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 21/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class CodeSignInViewController: UIViewController {

    enum Constants {
        static let changeNumber = "Изменить номер"
        static let code = "Код из СМС"
        static let nextButton = "Продолжить"
        static let repeatNumber = "Отправить повторное СМС"
    }
    

    // MARK: - Private Properties
    
    private lazy var headerView = LogoHeaderView(.icon, leftButton: leftButton)
    
    private let leftButton = HeaderButton(type: .back)
    
    private let repeatNumber = UIButton()
    
    private let textField = StuddyBuddyTextField()
    
    private let changeNumberButton = UIButton()
    
    private let nextButton = FilledButton(
        color: CommonAsset.Colors.mainPurple.color,
        text: Constants.nextButton,
        imagePadding: 8,
        image: CommonAsset.Buttons.arrow.image
    )
    
    private lazy var descriptionLabel = DescriptionLabel(spacing: 10)

    private let viewModel: CodeSignInViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: CodeSignInViewModel) {
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

private extension CodeSignInViewController {

    func setup() {
        view.backgroundColor = .white
        
        headerView.addHeader(to: view)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16))
        descriptionLabel.pin(side: .top(30), to: .bottom(headerView))
        descriptionLabel.configure(type: .codeSignIn)
        
        view.addSubview(changeNumberButton)
        changeNumberButton.pinToSuperView(sides: .left(16))
        changeNumberButton.pin(side: .top(10), to: .bottom(descriptionLabel))
        changeNumberButton.setTitle(Constants.changeNumber, for: .normal)
        changeNumberButton.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
        changeNumberButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        view.addSubview(textField)
        textField.pinToSuperView(sides: .left(16), .right(-16))
        textField.pin(side: .top(30), to: .bottom(changeNumberButton))
        textField.placeholder = Constants.code
        
        view.addSubview(nextButton)
        nextButton.pinToSuperView(sides: .left(16), .right(-16))
        nextButton.pin(side: .top(40), to: .bottom(textField))
        nextButton.setDemission(.height(47))
        
        view.addSubview(repeatNumber)
        repeatNumber.pinToSuperView(sides: .left(18))
        repeatNumber.pin(side: .top(20), to: .bottom(nextButton))
        repeatNumber.setTitle(Constants.repeatNumber, for: .normal)
        repeatNumber.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
    }

    func bind() {
        leftButton.onActionPublisher
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.back()
            }
            .store(in: &cancellableSet)
        
        nextButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.back()
            }
            .store(in: &cancellableSet)
    }

}
