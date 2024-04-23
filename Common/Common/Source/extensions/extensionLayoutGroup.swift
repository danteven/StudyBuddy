//
//  extensionLayoutGroup.swift
//  Common
//
//  Created by Shamil Mazitov on 06.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

public extension NSCollectionLayoutGroup {


    // лучше функцию не трогать, ее кто-то написал и слава богу что работает
    // FIXME: поправить как будет время
    /// func for centring cells in collection view group
    static func verticallyCentered(
        cellSizes: [CGSize],
        interItemSpacing: CGFloat = 8,
        interRowSpacing: CGFloat = 8,
        topSpasing: CGFloat = 24
    ) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
        return custom(layoutSize: groupSize) { environment in

            func totalWidth() -> CGFloat {
                rowSizes.map(\.width).reduce(0) {
                    $0 == 0 ? $1 : $0 + interItemSpacing + $1
                }
            }

            func addRowItems() {
                var xPos = (environment.container.effectiveContentSize.width - totalWidth())/2 + environment.container.contentInsets.leading
                let maxItemHeight = rowSizes.map(\.height).max() ?? 0
                let rowItems: [NSCollectionLayoutGroupCustomItem] = rowSizes.map {
                    let rect = CGRect(origin: CGPoint(x: xPos, y: yPos + (maxItemHeight - $0.height) / 2), size: $0)
                    xPos += ($0.width + interItemSpacing)
                    return NSCollectionLayoutGroupCustomItem(frame: rect)
                }

                items.append(contentsOf: rowItems)
            }
            
            var items: [NSCollectionLayoutGroupCustomItem] = []

            var yPos: CGFloat = environment.container.contentInsets.top + topSpasing

            var rowSizes: [CGSize] = []

            for (index, cellSize) in cellSizes.enumerated() {
                rowSizes.append(cellSize)

                if totalWidth() > environment.container.effectiveContentSize.width {
                    rowSizes.removeLast()
                    addRowItems()
                    yPos += (cellSize.height + interRowSpacing)
                    rowSizes = [cellSize]
                }

                if index == cellSizes.count - 1 {
                    addRowItems()
                }
            }
            return items
        }
    }
}
