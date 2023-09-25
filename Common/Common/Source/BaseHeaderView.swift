//
//  BaseHeaderView.swift
//  SignInCoordinator
//
//  Created by Shamil Mazitov on 21.09.2023.
//  Copyright © 2023 OneGo. All rights reserved.
//

import UIKit

open class BaseHeaderView: UIView {

    // MARK: - Init

    public init() {
        super.init(frame: .zero)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    /// add header to superview and set constraints
    public func addHeader(to view: UIView) {
        view.addSubview(self)
        pinToSuperView(sides: [.leftR, .rightR])
        setDemission(.height(64))
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

}
