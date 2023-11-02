//
//  CheckBox.swift
//  Common
//
//  Created by Shamil Mazitov on 13.10.2023.
//  Copyright © 2023 StuddyBuddy. All rights reserved.
//

import UIKit
import Combine

public final class CheckBox: UIView {

    // MARK: - Public properties

    public var onTapActionPublisher: AnyPublisher<Bool, Never> {
        onTapActionSubject.eraseToAnyPublisher()
    }

    public var isActive: Bool = false {
        didSet {
            imageView.isHidden = !isActive
        }
    }

    // MARK: - Private properties

    private var imageView = UIImageView(image: CommonAsset.CheckBox.checkbox.image)

    private var onTapActionSubject = PassthroughSubject<Bool, Never>()

    // MARK: - Init

    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK - Private methods

private extension CheckBox {
    func setup() {
        layer.cornerRadius = 4
        layer.borderWidth = 2
        layer.borderColor = CommonAsset.Colors.mainPurple.color.cgColor

        addSubview(imageView)
        imageView.pinToSuperView()
        imageView.isHidden = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }

    @objc
    func tapAction() {
        isActive = !isActive
        onTapActionSubject.send(isActive)
    }
}
