//
//  PurpleViewCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 01.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class PurpleViewCell: UICollectionViewCell {
    
    
    // MARK: - Private properties
    
    private let purpleView = PurpleView()
        
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
    
    public func configure(_ name: String) {
        purpleView.configure(type: .purpleViewData("Арефуллин"))
    }
}

// MARK: - Private methods

private extension PurpleViewCell {
    func setup() {
        contentView.addSubview(purpleView)
        purpleView.pinToSuperView()
        purpleView.layer.cornerRadius = 25
        purpleView.setDemission(.height(150))
    }
    
    func bind() {

    }
}
