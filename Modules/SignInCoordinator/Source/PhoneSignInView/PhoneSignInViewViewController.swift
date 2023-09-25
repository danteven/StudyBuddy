//
//  PhoneSignInViewViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 17/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class PhoneSignInViewViewController: UIViewController {

    enum Constants {
        static let entry = "Вход в личный кабинет"
        static let enter = "Войти"
        static let noAccount = "Нет аккаунта?"
        static let registerStudent = "Зарегистрироваться как ученик"
        static let registerTeacher = "Зарегистрироваться как репетитор"
    }
    
    enum Section {
        case phone
        case email
    }
    
    enum Items {
        case phone
        case email
    }

    // MARK: - Private Properties
    
    private let logoImageView = UIImageView()
    
    private let descriptionLabel = UILabel()
        
    private let containerView = UIView()
    
    private let accountLabel = UILabel()
    
    private let registerStudentButton = UIButton()
    
    private let registerTeacherButton = UIButton()
    
    private lazy var tableCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    )
    
    private lazy var contentCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCompositionalLayout()
    )
    
    private lazy var diffableDataSource = configureDataSource()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        return layout
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { sectionIndex, layoutEnvironment in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(1.0)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            },
            configuration: config
        )
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Items >{
        let dataSource = UICollectionViewDiffableDataSource<Section, Items>(collectionView: contentCollectionView) { [weak self] (collectionView, indexPath, model) in
            guard let self else { return UICollectionViewCell() }
            switch model {
            case .email:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignInCollectionEmailCell", for: indexPath) as! SignInCollectionEmailCell
                return cell
            case .phone:
                let cell: SignInCollectionPhoneCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignInCollectionPhoneCell", for: indexPath) as! SignInCollectionPhoneCell
                cell.onActionPublisher
                    .withUnretained(self)
                    .sink { view, _ in
                        view.viewModel.enterCodeView()
                    }
                    .store(in: &cancellableSet)
                return cell
            }
        }
        return dataSource
    }

}

// MARK: - Private methods

private extension PhoneSignInViewViewController {

    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(logoImageView)
        logoImageView.pinToSuperView(sides: .left(16))
        logoImageView.pinToSafeArea(side: .topR, to: .top(view))
        logoImageView.setDemission(.height(40))
        logoImageView.setDemission(.width(93))
        logoImageView.image = CommonAsset.logoSB.image
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinToSuperView(sides: .left(16), .right(-16))
        descriptionLabel.pin(side: .top(30), to: .bottom(logoImageView))
        descriptionLabel.text = Constants.entry
        descriptionLabel.font = .boldSystemFont(ofSize: 30)
        descriptionLabel.textColor = .black
        
        view.addSubview(tableCollectionView)
        tableCollectionView.pinToSuperView(sides: .left(16), .right(-16))
        tableCollectionView.pin(side: .top(20), to: .bottom(descriptionLabel))
        tableCollectionView.register(SignInCollectionTabCell.self, forCellWithReuseIdentifier: "TableCollectionView")
        tableCollectionView.dataSource = self
        tableCollectionView.setDemission(.height(50))
        tableCollectionView.isScrollEnabled = false
        tableCollectionView.allowsMultipleSelection = false
        tableCollectionView.delegate = self
        
        view.addSubview(containerView)
        containerView.pinToSuperView(sides: .left(16), .right(-16))
        containerView.backgroundColor = CommonAsset.Colors.greyLight.color
        containerView.setDemission(.height(140))
        containerView.layer.cornerRadius = 20
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        containerView.addSubview(accountLabel)
        accountLabel.pinToSuperView(sides: .top(20), .left(20))
        accountLabel.text = Constants.noAccount
        accountLabel.font = .systemFont(ofSize: 16)
        
        containerView.addSubview(registerStudentButton)
        registerStudentButton.pinToSuperView(sides: .left(20))
        registerStudentButton.pin(side: .top(10), to: .bottom(accountLabel))
        registerStudentButton.setTitle(Constants.registerStudent, for: .normal)
        registerStudentButton.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
        
        containerView.addSubview(registerTeacherButton)
        registerTeacherButton.pinToSuperView(sides: .left(20))
        registerTeacherButton.pin(side: .top(5), to: .bottom(registerStudentButton))
        registerTeacherButton.setTitle(Constants.registerTeacher, for: .normal)
        registerTeacherButton.setTitleColor(CommonAsset.Colors.mainPurple.color, for: .normal)
        
        view.addSubview(contentCollectionView)
        contentCollectionView.pinToSuperView(sides: [.leftR, .rightR])
        contentCollectionView.pin(side: .topR, to: .bottom(tableCollectionView))
        contentCollectionView.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: -200).isActive = true
        contentCollectionView.register(SignInCollectionPhoneCell.self, forCellWithReuseIdentifier: "SignInCollectionPhoneCell")
        contentCollectionView.register(SignInCollectionEmailCell.self, forCellWithReuseIdentifier: "SignInCollectionEmailCell")
        contentCollectionView.delegate = self
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.isScrollEnabled = false
        
        addInitialSnapshot()
        
        
    }
    
    func addInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Items>()
        snapshot.appendSections([.phone, .email])
        snapshot.appendItems([.phone], toSection: .phone)
        snapshot.appendItems([.email], toSection: .email)

        diffableDataSource.apply(snapshot)
    }

    func bind() { }

}

extension PhoneSignInViewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tableSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableCollectionView", for: indexPath) as! SignInCollectionTabCell
        cell.configure(with: viewModel.tableSections[indexPath.row])
        return cell
    }
}

extension PhoneSignInViewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == self.tableCollectionView else { return }
        contentCollectionView.scrollToItem(
            at: IndexPath(
                item: 0,
                section: indexPath.row
            ),
            at: .centeredHorizontally, animated: true
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard collectionView == contentCollectionView,
              self.tableCollectionView.numberOfItems(inSection: 0) > indexPath.section
        else { return }
        collectionView.selectItem(at: IndexPath(row: 0, section: indexPath.section), animated: true, scrollPosition: .top)
    }
}
