//
//  InstructionsViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 29/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class InstructionsViewController: UIViewController {

    enum Constants {
        static let repeatButton = "Отправить повторно"
    }

    // MARK: - Private Properties

    private let contentView = UIView()
    private let imageView = UIImageView()
    private let descriptionLabel = DescriptionLabel()
    private let repeatButton = UIButton()
    private let closeButton = UIButton()
    private let viewModel: InstructionsViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: InstructionsViewModel) {
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

private extension InstructionsViewController {

    func setup() {
        view.backgroundColor = .black.withAlphaComponent(0.9)
        
        view.addSubview(contentView)
        contentView.pinToSuperView(sides: .left(16), .right(-16))
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 161).isActive = true
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .white
        contentView.setDemission(.height(319))
        
        view.addSubview(closeButton)
        closeButton.pinToSuperView(sides: .right(-16))
        closeButton.pin(side: .bottom(-10), to: .top(contentView))
        closeButton.setEqualSize(constant: 24)
        closeButton.setImage(CommonAsset.Buttons.close.image, for: .normal)
        
        contentView.addSubview(imageView)
        imageView.pinToSuperView(sides: .centerXR)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        imageView.setEqualSize(constant: 50)
        imageView.image = CommonAsset.email.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(20), .right(-20))
        descriptionLabel.pin(side: .top(20), to: .bottom(imageView))
        descriptionLabel.configure(type: .codeEmail)
        
        contentView.addSubview(repeatButton)
        repeatButton.pinToSuperView(sides: .centerXR, .bottom(-20))
        repeatButton.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
        repeatButton.setTitle(Constants.repeatButton, for: .normal)
        repeatButton.titleLabel?.font = .systemFont(ofSize: 16)
        
    }

    func bind() {
        closeButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.close()
            }
            .store(in: &cancellableSet)
    }

}
