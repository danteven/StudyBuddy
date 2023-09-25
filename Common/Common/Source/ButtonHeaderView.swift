//
//  ButtonHeaderView.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit

public class ButtonHeaderView: BaseHeaderView {

    // MARK: - Internal properties

    let leftButton: UIView?
    let rightButton: UIView?

    // MARK: - Init

    public init(
        leftButton: UIView? = nil,
        rightButton: UIView? = nil
    ) {
        self.leftButton = leftButton
        self.rightButton = rightButton
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Private Methods

private extension ButtonHeaderView {

    func setup() {
        if let leftButton {
            addSubview(leftButton)
            leftButton.pinToSuperView(sides: [.left(16), .centerYR])
        }

        if let rightButton {
            addSubview(rightButton)
            rightButton.pinToSuperView(sides: [.right(-16), .centerYR])
        }
    }
    
}
