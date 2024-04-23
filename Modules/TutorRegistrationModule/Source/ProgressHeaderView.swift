//
//  ProgressHeaderView.swift
//  Common
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

open class ProgressHeaderView: UIView {

    // MARK: - Init
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    public init() {
        super.init(frame: .zero)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    /// add header to superview and set constraints
    public func addHeader(to view: UIView) {
        view.addSubview(self)
        pinToSuperView(sides: [.leftR, .rightR])
        setDemission(.height(30))
    }

}

private extension ProgressHeaderView {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: frame.size.width/2, height: frame.size.height)
        return layout
    }
    
    func setup() {
        addSubview(collectionView)
        collectionView.pinToSuperView()
        collectionView.register(Tut, forCellWithReuseIdentifier: <#T##String#>)
    }
}
