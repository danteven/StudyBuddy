//
//  SubjectsCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 04.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common
import Combine

public class SubjectsCell: UICollectionViewCell {
    
    enum Constants {
        static let placeholder = "Введите название предмета"
    }
    
    enum Section: Hashable {
        case subjects
        case textField
    }
    
    enum Items: Hashable {
        case subject([String])
        case chooseSubject([String]?)
        
        public static func == (lhs: Items, rhs: Items) -> Bool {
            lhs.hashValue == rhs.hashValue
        }
    }
    
    var changeInModelPublisher: CustomPublisher<SubjectsCellAction> {
        changeInModelSubject.eraseToAnyPublisher()
    }
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout(needHeader: false))
    
    var viewModel: SubjectsCellViewModel?
    
    let containerView = UIView()
    
    var topContraint: NSLayoutConstraint?
    
    var heightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Private properties

    
    private let textField = StuddyBuddyTextField()
    
    private let changeInModelSubject = CustomSubject<SubjectsCellAction>()
        
    private lazy var diffableDataSource = configureDataSource()
        
    private var cancellable = [String: AnyCancellable]()
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func setupConstraints() {
        mainCollectionView.pinToSuperView(sides: .leftR, .rightR, .bottomR)
        topContraint = mainCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor)
        topContraint?.isActive = true
    }
    
    func configure(viewModel: SubjectsCellViewModel) {
        self.viewModel = viewModel
        
        initialSnapshot()
    }
    
    func initialSnapshot() {
        var snapshot = diffableDataSource.snapshot()
        snapshot.appendSections([.subjects, .textField])
        snapshot.appendItems([.chooseSubject(viewModel?.model)], toSection: .textField)
        diffableDataSource.apply(snapshot)
    }
}

// MARK: - Private methods

private extension SubjectsCell {
    func setup() {
        heightConstraint = mainCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500)
        heightConstraint?.isActive = true
        
        contentView.addSubview(mainCollectionView)
        setupConstraints()
        mainCollectionView.register(PurpleSubjectCell.self)
        mainCollectionView.register(ChooseSubjectCell.self)
        mainCollectionView.dataSource = self.diffableDataSource
        mainCollectionView.showsVerticalScrollIndicator = false
        mainCollectionView.isScrollEnabled = false
    }
    
    func bind() {
       
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Items> {
            let dataSource = UICollectionViewDiffableDataSource<Section, Items>(collectionView: mainCollectionView) { [weak self] (collectionView, indexPath, model) in
                guard let self else { return UICollectionViewCell() }
                switch model {
                case let .subject(model):
                    let cell: PurpleSubjectCell = collectionView.dequeue(for: indexPath)
                    cell.configure(model: model)
                    cancellable[cell.id] = cell.deletePublisher
                        .withUnretained(self)
                        .sink { cell, id in
                            cell.deleteInSnapshot(id: id)
                            cell.changeInModelSubject.send(.delete(id))
                        }
                    return cell
                case let .chooseSubject(model):
                    let cell: ChooseSubjectCell = collectionView.dequeue(for: indexPath)
                    cell.configure(model: model ?? [])
                    cell.cellActionPublisher
                        .withUnretained(self)
                        .sink { view, type in
                            view.cellAction(type: type)
                        }
                        .store(in: &cancellableSet)
                    return cell
                }
            }
            return dataSource
    }
    
    func cellAction(type: CellActions) {
        switch type {
        case let .choose(string):
            addToSnapshot(model: string)
            changeInModelSubject.send(.add(string))
        case let .updateConstraints(bool):
            if bool {
                UIView.animate(withDuration: 0.3) {
//                    self.heightConstraint?.constant = 350
//                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    func deleteInSnapshot(id: String) {
        guard let viewModel else { return }
        var snapshot = diffableDataSource.snapshot()
        guard viewModel.addedItems.count != 1 else {
            viewModel.addedItems.removeAll()
            snapshot.deleteSections([.subjects, .textField])
            snapshot.appendSections([.textField])
            snapshot.appendItems([.chooseSubject(viewModel.model)], toSection: .textField)
            diffableDataSource.apply(snapshot)
            return
        }
        snapshot.deleteSections([.textField])
        snapshot.deleteItems([.subject(viewModel.addedItems.compactMap{ $0 })])
        viewModel.addedItems.remove(id)
        let newList = viewModel.model.compactMap { sub in
            if !viewModel.addedItems.contains(sub) {
                return sub
            } else {
                return nil
            }
        }
        snapshot.appendSections([.textField])
        snapshot.appendItems([.subject(viewModel.addedItems.compactMap{ $0 })], toSection: .subjects)
        snapshot.appendItems([.chooseSubject(newList)], toSection: .textField)
        diffableDataSource.apply(snapshot)
    }
    
    func addToSnapshot(model: String) {
        guard let viewModel else { return }
        var snapshot = diffableDataSource.snapshot()
        snapshot.deleteSections([.subjects, .textField])
        viewModel.addedItems.insert(model)
        let newList = viewModel.model.compactMap { sub in
            if !viewModel.addedItems.contains(sub) {
                return sub
            } else {
                return nil
            }
        }
        snapshot.appendSections([.subjects, .textField])
        snapshot.appendItems([.subject(viewModel.addedItems.compactMap{ $0 })], toSection: .subjects)
        snapshot.appendItems([.chooseSubject(newList)], toSection: .textField)
        if #available(iOS 15.0, *) {
            diffableDataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            diffableDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func createLayout(pinHeader: Bool? = nil, needHeader: Bool) -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                guard let self else { return nil }
                let widthDimension = NSCollectionLayoutDimension.fractionalWidth(1.0)
                let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: .estimated(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                if needHeader {
                    let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "SBCollectionHeader-kind", alignment: .top)
                    if let pinHeader,
                    pinHeader {
                        header.pinToVisibleBounds = false
                    }
                    section.boundarySupplementaryItems = [header]
                }
                
                return section
            },
            configuration: config
        )
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width, height: 30)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }
    
}


