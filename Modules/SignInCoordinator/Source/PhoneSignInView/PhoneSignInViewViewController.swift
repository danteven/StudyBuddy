//
//  PhoneSignInViewViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 17/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Combine

final class PhoneSignInViewViewController: UIViewController {

    enum Constants {
        static let entry = "Вход в личный кабинет"
    }

    // MARK: - Private Properties
    
    private let logoImageView = UIImageView()
    
    private let descriptionLabel = UILabel()
    
    private lazy var tableCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )

    private let viewModel: PhoneSignInViewViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: PhoneSignInViewViewModel) {
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
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width / 3 - 42, height: 52)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }

}

// MARK: - Private methods

private extension PhoneSignInViewViewController {

    func setup() {
        view.addSubview(logoImageView)
        logoImageView.pinToSuperView(sides: .left(16))
        logoImageView.pinToSafeArea(side: .topR, to: .top(view))
        logoImageView.setDemission(.height(40))
        logoImageView.setDemission(.width(93))
        logoImageView.image = SignInCoordinatorAsset.logoSB.image
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16))
        descriptionLabel.pin(side: .top(30), to: .bottom(logoImageView))
        descriptionLabel.text = Constants.entry
        descriptionLabel.font = .boldSystemFont(ofSize: 30)
        descriptionLabel.textColor = .black
        
        view.addSubview(tableCollectionView)
        tableCollectionView.pinToSuperView(sides: .left(16), .right(-16))
        tableCollectionView.pin(side: .top(20), to: .bottom(descriptionLabel))
        tableCollectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: "TableCollectionView")
        
    }

    func bind() {
    }

}
