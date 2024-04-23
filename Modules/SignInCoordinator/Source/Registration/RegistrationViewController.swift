//
//  RegistrationViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 12/10/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class RegistrationViewController: UIViewController {

    enum Constants {
        static let name = "Имя"
        static let namePlaceholder = "Введите имя"
        static let number = "Номер телефона"
        static let email = "Электронная почта"
        static let emailPlaceholeder = "Введите электронную почту"
        static let registrationButton = "Зарегистрироваться"
        static let checkLabel = "Нажимая «Опубликовать», вы соглашаетесь на обработку персональных данных и условия сервиса"
        static let enterLabel = "Уже есть аккаунт?"
        static let enterButton = "Войти"
        static let offert = "Соглашаюсь с офертой"
    }

    // MARK: - Private Properties
    
    // FIXME: - Сделать универсальный компонент для тестфилдов
    
    private lazy var headerView = LogoHeaderView(.icon, leftButton: backButton)
    
    private let backButton = HeaderButton(type: .back)
    
    private let descriptionLabel = DescriptionLabel()
    
    private let nameTextField = StuddyBuddyTextField(title: Constants.name)
    
    private let phoneTextField = StuddyBuddyTextField(title: Constants.number)
    
    private let emailTextField = StuddyBuddyTextField(title: Constants.email)
    
    private let registrationButton = SBButton(type: .filled(Constants.registrationButton))
    
    private let firstCheckBox = CheckBox()
    
    private let secondCheckBox = CheckBox()
    
    private let enterButton = UIButton()
    
    private let firstCheckLabel = UILabel()
    
    private let secondCheckLabel = UILabel()

    private let viewModel: RegistrationViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: RegistrationViewModel) {
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

private extension RegistrationViewController {

    func setup() {
        view.backgroundColor = .white
        headerView.addHeader(to: view)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16))
        descriptionLabel.pin(side: .top(40), to: .bottom(headerView))
        descriptionLabel.configure(type: viewModel.type == .student ? .registrationStudent : .registrationTutor)
        
        view.addSubview(nameTextField)
        nameTextField.pinToSuperView(sides: .left(16), .right(-16))
        nameTextField.pin(side: .top(20), to: .bottom(descriptionLabel))
        nameTextField.placeholder = Constants.namePlaceholder
        
        view.addSubview(phoneTextField)
        phoneTextField.pinToSuperView(sides: .left(16), .right(-16))
        phoneTextField.pin(side: .top(20), to: .bottom(nameTextField))
        phoneTextField.setView(image: CommonAsset.flag.image, side: .left, frameView: CGRect(x: 0, y: 0, width: 24, height: 30), frameContainer: CGRect(x: 0, y: 0, width: 32, height: 30))
        phoneTextField.placeholder = "+7 000 000-00-00"
        
        view.addSubview(emailTextField)
        emailTextField.pinToSuperView(sides: .left(16), .right(-16))
        emailTextField.pin(side: .top(20), to: .bottom(phoneTextField))
        emailTextField.placeholder = Constants.email
        
        view.addSubview(registrationButton)
        registrationButton.pinToSuperView(sides: .left(16), .right(-16))
        registrationButton.pin(side: .top(20), to: .bottom(emailTextField))
        registrationButton.setDemission(.height(47))
        
        let greyView = UIView()
        greyView.backgroundColor = CommonAsset.Colors.greyLight.color
        view.addSubview(greyView)
        greyView.pinToSuperView(sides: .left(16), .right(-16))
        greyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        greyView.setDemission(.height(62))
        greyView.layer.cornerRadius = 20
        greyView.clipsToBounds = true
        
        let enterLabel = UILabel()
        enterLabel.text = Constants.enterLabel
        enterLabel.textColor = .black
        enterLabel.font = .systemFont(ofSize: 16)
        
        greyView.addSubview(enterLabel)
        enterLabel.pinToSuperView(sides: .centerYR, .left(20))
        
        greyView.addSubview(enterButton)
        enterButton.pinToSuperView(sides: .centerYR, .right(-16))
        enterButton.setTitle(Constants.enterButton, for: .normal)
        enterButton.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
        enterButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        firstCheckLabel.lineBreakMode = .byWordWrapping
        firstCheckLabel.numberOfLines = 0
        let attrString = getAttributeString(
            text: Constants.checkLabel,
            lineSpacing: 6,
            range: NSRange(location: 0, length: 74),
            secondRange: NSRange(location: 75, length: 15),
            colors: [
                CommonAsset.Colors.darkGrey.color,
                CommonAsset.Colors.mainPurple.color
            ]
        )
//        attrString.addAttributes([
//            .strokeColor: CommonAsset.Colors.mainPurple.color
//        ], range: NSRange(location: 71, length: Constants.checkLabel.count))
        firstCheckLabel.attributedText = attrString
        
        let stackView = UIStackView(arrangedSubviews: [firstCheckBox, firstCheckLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        view.addSubview(stackView)
        stackView.pinToSuperView(sides: .left(16), .right(-16))
        stackView.pin(side: .top(16), to: .bottom(registrationButton))
        
        guard viewModel.type == .tutor else { return }
        secondCheckLabel.text = Constants.offert
        let secondStack = UIStackView(arrangedSubviews: [secondCheckBox, secondCheckLabel])
        secondStack.axis = .horizontal
        secondStack.distribution = .fill
        secondStack.spacing = 10
        secondStack.alignment = .leading
        view.addSubview(secondStack)
        secondStack.pinToSuperView(sides: .left(16))
        secondStack.pin(side: .top(16), to: .bottom(stackView))
        
        let secondAttrString = getAttributeString(
            text: Constants.offert,
            lineSpacing: 6,
            range: NSRange(location: 0, length: 12),
            secondRange: NSRange(location: 13, length: 7),
            colors: [
                CommonAsset.Colors.darkGrey.color,
                CommonAsset.Colors.mainPurple.color
            ]
        )
        secondCheckLabel.attributedText = secondAttrString
        
    }
    
    func getAttributeString(
        text: String,
        lineSpacing: CGFloat,
        range: NSRange,
        secondRange: NSRange? = nil,
        colors: [UIColor]
    ) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        attrString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
        attrString.addAttribute(.foregroundColor, value: colors.first, range: range)
        guard let secondRange else { return attrString}
        attrString.addAttribute(.foregroundColor, value: colors.last, range: secondRange)
        return attrString
    }

    func bind() {
        backButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.buttonAction(type: .back)
            }
            .store(in: &cancellableSet)
        
        registrationButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.buttonAction(type: .registration(view.nameTextField.text))
            }
            .store(in: &cancellableSet)
    }

}
