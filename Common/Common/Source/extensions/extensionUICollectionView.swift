//
//  extensionUICollectionView.swift
//  Common
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import UIKit

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionReusableView>(header: T.Type, ofKind: String) {
        register(T.self, forSupplementaryViewOfKind: ofKind, withReuseIdentifier: T.reuseIdentifier)
    }

    /// Get collection view cell
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func dequeue<T: UICollectionReusableView>(for indexPath: IndexPath, ofKind: String) -> T {
        return dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
