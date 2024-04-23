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

    enum Constants { 
        static let continueReg = "Продолжить"
    }

    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = LoggerColelctionView(frame: .zero, collectionViewLayout: createLayoutMain())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [backButton,nextButton])
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fillProportionally
        return view
    }()
    
    private(set) lazy var nextButton = SBButton(type: .filled(Constants.continueReg), needArrow: true)
        
    private(set) lazy var backButton = UIButton()
    
    private let line = UIView()
    
    private let progressHeader = ProgressHeaderView()
    
    private let viewModel: TutorRegistrationViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: TutorRegistrationViewModel) {
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

private extension TutorRegistrationController {

    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.pinToSuperView(sides: .left(16))
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.setDemission(.height(24))
        imageView.contentMode = .scaleAspectFill
        imageView.image = CommonAsset.logoSB.image
        
        view.addSubview(line)
        line.pinToSuperView(sides: .leftR, .rightR)
        line.pin(side: .top(16), to: .bottom(imageView))
        line.setDemission(.height(2))
        line.layer.cornerRadius = 2
        line.backgroundColor = CommonAsset.Colors.grey.color
        
        view.addSubview(collectionView)
        collectionView.pinToSuperView(sides: .left(16), .right(-16))
        collectionView.pin(side: .top(16), to: .bottom(line))
        collectionView.setDemission(.height(40))
        collectionView.register(TutorRegistrationHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
        
        view.addSubview(buttonStackView)
        buttonStackView.pinToSuperView(sides: [.left(16), .right(-16)])
        buttonStackView.setDemission(.height(50))
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        if #available(iOS 15.0, *) {
            var config: UIButton.Configuration = .filled()
            config.imagePlacement = .all
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
            config.background.cornerRadius = 25
            config.image = TutorRegistrationModuleAsset.leftArrow.image
            config.baseBackgroundColor = CommonAsset.Colors.greyLight.color
            backButton.configuration = config
        } else {
            backButton.setImage(TutorRegistrationModuleAsset.leftArrow.image, for: .normal)
            backButton.backgroundColor = CommonAsset.Colors.greyLight.color
            backButton.layer.cornerRadius = 25
            backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        view.addSubview(mainCollectionView)
        mainCollectionView.pinToSuperView(sides: [.left(16), .right(-16)])
        mainCollectionView.pin(side: .top(30), to: .bottom(collectionView))
        mainCollectionView.pin(side: .bottom(-10), to: .top(buttonStackView))
        mainCollectionView.register(RegistrationCell.self)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.isScrollEnabled = false
        mainCollectionView.clipsToBounds = true
        mainCollectionView.isPagingEnabled = true
        
    }

    func bind() {
        viewModel.onCurrentStepPublisher
            .withUnretained(self)
            .sink { view, item in
                view.scrollto(item: item)
            }
            .store(in: &cancellableSet)
        
        viewModel.onNextButtonStatePublisher
            .withUnretained(self)
            .sink { view, value in
                guard view.viewModel.currentStep == value.1.serialNumber else { return }
                view.setButton(style: RegistrationButtonState(is: value.0.isValid))
            }
            .store(in: &cancellableSet)
        
        backButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.buttonAction(of: .back)
            }
            .store(in: &cancellableSet)
        
        nextButton.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                view.viewModel.buttonAction(of: .next)
            }
            .store(in: &cancellableSet)
        
    }
    
    func scrollto(item: Int) {
        self.mainCollectionView.scrollToItem(at: IndexPath(row: item, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func setButton(style: RegistrationButtonState) {
        nextButton.setStyle(enabled: style.isValid)
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: 40)
        return layout
    }
    
    func createLayoutMain() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        return UICollectionViewCompositionalLayout(
            sectionProvider: {
                (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    ),
                    subitems: [item]
                )

                return NSCollectionLayoutSection(group: group)
            },
            configuration: config
        )
    }

}

extension TutorRegistrationController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == self.collectionView else {
            return viewModel.stepModule.count
        }
        return viewModel.model.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == self.collectionView else {
            let cell: RegistrationCell = collectionView.dequeue(for: indexPath)
            cell.configure(with: viewModel.stepModule[indexPath.row])
            return cell
        }
        let cell: TutorRegistrationHeaderCell = collectionView.dequeue(for: indexPath)
        let type = viewModel.stepModule[viewModel.currentStep].type
        cell.configure(model: viewModel.model[indexPath.row], done: viewModel.stepIsValid[type]?.isValid)
        return cell
    }
}

extension TutorRegistrationController: UICollectionViewDelegate { }

