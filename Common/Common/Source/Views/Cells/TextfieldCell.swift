//
//  TextfieldCell.swift
//  Common
//
//  Created by Shamil Mazitov on 30.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Combine

public class TextFieldCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var onSetTextPublisher: AnyPublisher<String?, Never> {
        get {
            textfield.onSetTextPublisher
        }
    }
    public var onReturnTextfieldPublisher: VoidPublisher {
        get {
            textfield.onReturnTextFiledPublisher
        }
    }
    public var onChangeTextfieldPublisher: CustomPublisher<ChangeTextfieldType> {
        get {
            textfield.onChangeTextfieldPublisher
        }
    }
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    
    private lazy var textfield = StuddyBuddyTextField(setStatePublisher: onStateTextfieldSubject.eraseToAnyPublisher())
    
    private let onStateTextfieldSubject = PassthroughSubject<TextFieldStateType, Never>()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func setActionPublisher(_ publisher: AnyPublisher<TextfieldCellAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .withUnretained(self)
            .sink { cell, action in
                switch action {
                case .updateText(let text):
                    cell.textfield.setText(text)
                case .updateState(let state):
                    cell.onStateTextfieldSubject.send(state)
                case .becomeFirstResponder:
                    cell.textfield.becomeFirstResponder()
                case .resignFirstResponder:
                    cell.textfield.resignFirstResponder()
                }
            }
            .store(in: &cancellableSet)
    }
    
    public func configure(_ placeholder: String, enableNumPad: Bool = false, title: String) {
        textfield.placeholder = placeholder
        titleLabel.text = title
        guard enableNumPad else { return }
        textfield.keyboardType = .numberPad
    }
    
    public func configure(text: String?) {
        textfield.setText(text)
        textfield.textColor = CommonAsset.Colors.grey.color
        textfield.isEnabled = false
    }
    
}

// MARK: - Private methods

private extension TextFieldCell {
    func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .left(16), .right(-16), .topR)
        titleLabel.font = .systemFont(ofSize: 16)

        contentView.addSubview(textfield)
        textfield.pinToSuperView(sides: .left(16), .right(-16))
        textfield.pin(side: .topR, to: .bottom(titleLabel))
        textfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 42).isActive = true
        textfield.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -5).isActive = true
    }
    
    func bind() {
        textfield.onSetTextPublisher
            .withUnretained(self)
            .sink { cell, text in
                guard cell.textfield.keyboardType == .numberPad,
                      let text,
                      !text.isEmpty,
                      !text.contains("+")
                else { return }
                cell.textfield.setText("+\(text)")
            }
            .store(in: &cancellableSet)
    }
}
