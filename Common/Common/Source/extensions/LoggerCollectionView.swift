//
//  LoggerCollectionView.swift
//  Common
//
//  Created by Shamil Mazitov on 28.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

open class LoggerColelctionView: UICollectionView {
    
    open override var contentInset: UIEdgeInsets {
        get {
            return super.contentInset
        }
        set {
            super.contentInset = newValue
        }
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        if !Thread.current.isMainThread {
            return
        }
        super.layoutSublayers(of: layer)
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
