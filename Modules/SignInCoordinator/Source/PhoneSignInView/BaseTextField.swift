//
//  BaseTextField.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 20.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit
import Combine

public class BaseTextFiled: UITextField {

    // MARK: - Internal properties

    var onDeleBackward: PassthroughSubject<Void, Never>?

    var onGestureRecognizerShouldBeginPublisher: AnyPublisher<Void, Never> {
        onGestureRecognizerShouldBeginSubject.eraseToAnyPublisher()
    }

    // MARK: - Private properties

    private let onGestureRecognizerShouldBeginSubject = PassthroughSubject<Void, Never>()

    // MARK: - UITextField's methods
    
    public override func deleteBackward() {
        onDeleBackward?.send()
        super.deleteBackward()
    }

    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        onGestureRecognizerShouldBeginSubject.send()
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
