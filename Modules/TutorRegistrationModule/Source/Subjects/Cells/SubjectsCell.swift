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

public class SubjectsCell: UICollectionViewCell {
    
    enum Constants {
        static let placeholder = "Введите название предмета"
    }
    
    
    // MARK: - Private properties
    
    private let textField = StuddyBuddyTextField()
    
    private var topContraint: NSLayoutConstraint?
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout(needHeader: false))
    
    private lazy var subjectsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
    
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
    
    public func configure() {
    }
}

// MARK: - Private methods

private extension SubjectsCell {
    func setup() {
        contentView.addSubview(textField)
        textField.pinToSuperView(sides: .left(16), .right(-16))
        textField.placeholder = Constants.placeholder
        
        contentView.addSubview(collectionView)
        collectionView.pinToSuperView(sides: .topR, .left(16), .right(-16))
        collectionView.pin(side: .bottom(-20), to: .top(textField))
        collectionView.register(SBCollectionCell.self)
        
        contentView.addSubview(subjectsCollectionView)
        subjectsCollectionView.pinToSuperView(sides: .left(16), .right(-16), .bottomR)
        subjectsCollectionView.pin(side: .topR, to: .bottom(textField))
        subjectsCollectionView.isHidden = true
        subjectsCollectionView.dataSource = self
        subjectsCollectionView.register(<#T##cellType: T.Type##T.Type#>)
                
    }
    
    func bind() {
        
    }
    
    func createLayout(pinHeader: Bool? = nil, needHeader: Bool) -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                guard let self else { return nil }
                let widthDimension = NSCollectionLayoutDimension.estimated(1.0)
                let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: .absolute(56))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                    leading: .fixed(0),
                    top: .fixed(16),
                    trailing: .fixed(0),
                    bottom: .fixed(16)
                )
                                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                if needHeader {
                    let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "SBCollectionHeader-kind", alignment: .top)
                    if pinHeader {
                        header.pinToVisibleBounds = false
                    }
                    section.boundarySupplementaryItems = [header]
                }
                
                return section
            },
            configuration: config
        )
    }
    
    func createFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width, height: 30)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }
    
}
