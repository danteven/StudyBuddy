//
//  PurpleSubjectCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 06.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

public class PurpleSubjectCell: UICollectionViewCell {
    
    enum Section {
        case subjects
    }

    // MARK: - UICollectionViewCell properties
    
    public var deletePublisher: CustomPublisher<String> {
        deleteSubject.eraseToAnyPublisher()
    }
    
    public var id = UUID().uuidString

    // MARK: - Private properties

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout(needHeader: false))
    
    private lazy var diffableDataSource = configureDataSource()
    
    private var heightConstraint = NSLayoutConstraint()
    
    private let deleteSubject = CustomSubject<String>()
    
    private var cancellable = [String: AnyCancellable]()

    private var centerXConstraint: NSLayoutConstraint?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    
    func configure(model: [String]) {
        var snapshot = diffableDataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.subjects])
        snapshot.appendItems(model, toSection: .subjects)
        diffableDataSource.apply(snapshot)
        updateContsraint(count: snapshot.itemIdentifiers.count)
    }
    
    func updateContsraint(count: Int) {
        guard count != 1 else {
            heightConstraint.constant = 50
            return
        }
        guard count % 2 == 1 else {
            heightConstraint.constant = CGFloat(count * 25)
            return
        }
        heightConstraint.constant = CGFloat((count * 36) - (count * 4))
    }

}

// MARK: - Private methods

private extension PurpleSubjectCell {

    func setup() {
        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        contentView.addSubview(collectionView)
        collectionView.pinToSuperView()
        collectionView.register(SBCollectionCell.self)
        collectionView.dataSource = self.diffableDataSource
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.subjects])
        diffableDataSource.apply(snapshot)
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, String> {
            let dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { [weak self] (collectionView, indexPath, model) in
                guard let self else { return UICollectionViewCell() }
                let cell: SBCollectionCell = collectionView.dequeue(for: indexPath)
                cell.configure(with: model)
                cancellable[cell.id] = cell.deleteCellPublisher
                    .withUnretained(self)
                    .sink{ cell, id in
                        cell.deleteSubject.send(id)
                    }
                return cell
            }
            return dataSource
    }
    
    func deleteInSnapshot(id: String) {
        var snapshot = diffableDataSource.snapshot()
        guard snapshot.itemIdentifiers.count != 1 else {
            snapshot.deleteAllItems()
            diffableDataSource.apply(snapshot)
            return
        }
    }
    
    func addToSnapshot(model: String) {
        var snapshot = diffableDataSource.snapshot()
        guard !snapshot.itemIdentifiers(inSection: .subjects).contains(where: { $0 == model }) else { return }
        snapshot.appendItems([model], toSection: .subjects)
        if #available(iOS 15.0, *) {
            diffableDataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            diffableDataSource.apply(snapshot)
        }
    }
    
    func createLayout(pinHeader: Bool? = nil, needHeader: Bool) -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                guard let self else { return nil }
                let widthDimension = NSCollectionLayoutDimension.estimated(1.0)
                let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: .estimated(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                    leading: .fixed(4),
                    top: .fixed(8),
                    trailing: .fixed(4),
                    bottom: .fixed(8)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0)), subitems: [item])
                group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
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
    
    func bind() {

    }
}
