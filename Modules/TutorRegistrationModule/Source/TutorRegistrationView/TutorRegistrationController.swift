//
//  TutorRegistrationControler.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Combine
import Common

final class TutorRegistrationController: UIViewController {

    enum Constants { }

    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    
    private let line = UIView()

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init() {
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

private extension TutorRegistrationController {

    func setup() {
        view.addSubview(imageView)
        imageView.pinToSuperView(sides: .left(16), .top(16))
        imageView.setDemission(.height(24))
        imageView.contentMode = .scaleAspectFill
        imageView.image = CommonAsset.logoSB.image
        
        view.addSubview(line)
        line.pinToSuperView(sides: .leftR, .rightR)
        line.pin(side: .top(16), to: .bottom(imageView))
        line.setDemission(.height(2))
        line.layer.cornerRadius = 2
        line.backgroundColor = CommonAsset.Colors.greyLight.color
    }

    func bind() {
        //bind funcions
    }

}
