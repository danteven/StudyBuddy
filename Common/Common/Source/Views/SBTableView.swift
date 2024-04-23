//
//  SBTableView.swift
//  Common
//
//  Created by Shamil Mazitov on 30.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

open class SBTableView: LoggerColelctionView {
    
    // MARK: - Init

    public init(
        needHeader: Bool? = nil,
        pinHeader: Bool? = nil,
        itemSpacing: CGFloat? = nil,
        sectionInset: NSDirectionalEdgeInsets? = nil,
        twoItemsPerRow: Bool = false
    ) {
        super.init(
            frame: .zero,
            collectionViewLayout: SBTableView.createLayout(
                needHeader: needHeader,
                pinHeader: pinHeader,
                itemSpacing: itemSpacing,
                sectionInset: sectionInset,
                twoItemsPerRow: twoItemsPerRow
            )
        )
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension SBTableView {
    static func createLayout(
        needHeader: Bool?,
        pinHeader: Bool?,
        itemSpacing: CGFloat?,
        sectionInset: NSDirectionalEdgeInsets?,
        twoItemsPerRow: Bool
    ) -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { sectionIndex, layoutEnvironment in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: twoItemsPerRow ? .fractionalWidth(0.5) : .fractionalWidth(1.0),
                    heightDimension: .estimated(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(1.0)),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                if let needHeader {
                    
                        let headerFooterSize = NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .estimated(1.0)
                        )
                        let header = NSCollectionLayoutBoundarySupplementaryItem(
                            layoutSize: headerFooterSize,
                            elementKind: "SBTableHeader-kind",
                            alignment: .top
                        )
                    
                    if let pinHeader {
                        header.pinToVisibleBounds = pinHeader
                        
                    }
                        section.boundarySupplementaryItems = [header]
                }
                if let itemSpacing {
                    section.interGroupSpacing = itemSpacing
                }
                if let sectionInset {
                    section.contentInsets = sectionInset
                } else {
                    section.contentInsets = NSDirectionalEdgeInsets(
                        top: 10,
                        leading: 0,
                        bottom: 24,
                        trailing: 0
                    )
                }
                return section
            },
            configuration: config
        )
    }
}
