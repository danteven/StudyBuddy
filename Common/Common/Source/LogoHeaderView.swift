//
//  LogoHeaderView.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit

public class LogoHeaderView: ButtonHeaderView {

    // MARK: - Private properties

    private let logoType: LogoHeaderType
    private let logoImageView = UIImageView()

    // MARK: - Init

    public init(
        _ logoType: LogoHeaderType,
        leftButton: UIView? = nil,
        rightButton: UIView? = nil
    ) {
        self.logoType = logoType
        super.init(leftButton: leftButton,
                   rightButton: rightButton)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension LogoHeaderView {
    func setup() {
        addSubview(logoImageView)
        logoImageView.pinToSuperView(sides: [.centerYR, .centerXR])
        logoImageView.image = logoType.sbIcon
    }
}
