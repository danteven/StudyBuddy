//
//  StudyBuddyTextField.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 20.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit
import Combine

@dynamicMemberLookup
open class StuddyBuddyTextField: UIView {

    // MARK: - Public properties

    /// Get text of textFiled
    public var text: String? {
        get {
            return textField.text
        }
    }

    public override var inputView: UIView? {
        get {
            textField.inputView
        }
        set {
            textField.inputView = newValue
        }
    }

    /// Function which edit musk of textFiled
    public var textMask: ((String?) -> String?)?

    public var textField = BaseTextFiled()

    /// Notify when user delete Char from textFiled by backward
    public var onDeleBackward: PassthroughSubject<Void, Never>? {
        get {
            return textField.onDeleBackward
        }
        set {
            textField.onDeleBackward = newValue
        }
    }

    /// Notify that text changed in TextFiled
    public var onSetTextPublisher: AnyPublisher<String?, Never> {
        onChangeTextSubject.eraseToAnyPublisher()
    }

    /// Notify that user tap on textFiled
    public var onGestureRecognizerShouldBeginPublisher: AnyPublisher<Void, Never> {
        textField.onGestureRecognizerShouldBeginPublisher
    }

    /// Notify when presed return on keybvoard
    public var onReturnTextFiledPublisher: AnyPublisher<Void, Never> {
        onReturnTextFiledSubject.eraseToAnyPublisher()
    }
    
    private let setStatePublisher: AnyPublisher<TextFieldStateType, Never>?

    // MARK: - Private properties

    private let titleLabel = UILabel()
    private let line = UIView()
    private var errorLabel = UILabel()
    private let leftView = UIImageView()
    
    private let title: String?

    private var bottomConstraint: NSLayoutConstraint?
    
    private let onReturnTextFiledSubject = PassthroughSubject<Void, Never>()
    private let onChangeTextSubject = CurrentValueSubject<String?, Never>(nil)

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    
    /// Init object
    /// - Parameter setStatePublisher: Publisher for set valid state
    public init(setStatePublisher: AnyPublisher<TextFieldStateType, Never>? = nil, title: String? = nil) {
        self.setStatePublisher = setStatePublisher
        self.title = title
        super.init(frame: .zero)
        setup()
        bind()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView's methods

    @discardableResult
    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }

    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    // MARK: Public methods

    public func setText(_ text: String?) {
        textField.text = text
        onChangeTextSubject.send(text)
    }

    public subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<UITextField, T>) -> T {
        get { textField[keyPath: keyPath] }
        set { textField[keyPath: keyPath] = newValue }
    }
    
    public func setView(image: UIImage, side: TextFieldImageSide, frameView: CGRect, frameContainer: CGRect) {
        textField.setUpImage(imageName: image, on: side, frameContainer: frameContainer, frameImage: frameView)
    }
}


// MARK: - Private methods

private extension StuddyBuddyTextField {
    func setup() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,textField, line, errorLabel])
        addSubview(stackView)
        stackView.pinToSuperView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.text = title
        
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.addTarget(self, action: #selector(textFiledDidChange(textFiled:)), for: .editingChanged)
        textField.delegate = self
        
        line.setDemission(.height(1))
        line.backgroundColor = CommonAsset.Colors.grey.color

        errorLabel.font = UIFont.systemFont(ofSize: 15)
//        errorLabel.textColor = BebsCommonAsset.Color.redMain.color
    }

    func bind() {
//        setStatePublisher?
//            .sink { [weak self] answer in
//                let textColor = answer.isValid ?
//                BebsCommonAsset.Color.black.color :
//                BebsCommonAsset.Color.redMain.color
//                
//                self?.textField.textColor = textColor
//                
//                self?.errorLabel.textColor = answer.isValid ?
//                BebsCommonAsset.Color.blackSecond.color :
//                BebsCommonAsset.Color.redMain.color
//                
//                self?.line.backgroundColor = textColor
//                self?.errorLabel.text = answer.message
//                self?.bottomConstraint?.isActive = answer.message != nil
//            }
//            .store(in: &cancellableSet)
    }

    @objc
    func textFiledDidChange(textFiled: UITextField) {
        let text = textFiled.text
        if let textMask {
            self.textField.text = textMask(text)
        }
        onChangeTextSubject.send(self.textField.text)
    }
    
    @objc
    func doneAction() {
        resignFirstResponder()
    }
    
}

// MARK: - UITextFieldDelegate methods

extension StuddyBuddyTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturnTextFiledSubject.send()
        return true
    }
}

public enum TextFieldImageSide {
    case left
    case right
}

public extension UITextField {
    func setUpImage(imageName: UIImage, on side: TextFieldImageSide, frameContainer: CGRect, frameImage: CGRect) {
        let image = UIImageView(frame: frameImage)
        image.image = imageName
        let imageContainerView = UIView(frame: frameContainer)
        imageContainerView.addSubview(image)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        switch side {
        case .left:
            leftView = imageContainerView
            leftViewMode = .always
        case .right:
            rightView = imageContainerView
            rightViewMode = .always
        }
    }
}
