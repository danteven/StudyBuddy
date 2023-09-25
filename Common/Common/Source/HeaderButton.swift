//
//  HeaderButton.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit
import Combine

public class HeaderButton: UIButton {
    
    public var isLightContent: Bool {
        get {
            return tintColor == .white
        }
        set {
            guard newValue else { return }
            let image = type.image.withRenderingMode(.alwaysTemplate)
            setImage(image, for: .normal)
            tintColor = .white
        }
    }

    public var onActionPublisher: AnyPublisher<Void, Never> {
        onActionSubject.eraseToAnyPublisher()
    }

    // MARK: Private properties
    
    private let onActionSubject = PassthroughSubject<Void, Never>()
    private let type: HeaderButtonType

    // MARK: - Init

    public init(type: HeaderButtonType) {
        self.type = type
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeColor(isLight: Bool) {
        tintColor = isLight ? .white : .black
    }
}

// MARK: - Private methods

private extension HeaderButton {
    func setup() {
        setImage(type.image, for: .normal)
        setEqualSize(constant: 48)
        layer.cornerRadius = 24
//        backgroundColor = type.backgroundColor
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    @objc
    func buttonAction() {
        onActionSubject.send()
    }
}
