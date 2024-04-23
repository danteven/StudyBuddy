//
//  CheckBoxTitle.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 04.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import UIKit
import Common

public final class CheckBoxTitle: UIView {

    // MARK: - Public properties

  
    // MARK: - Private properties

    private let type: CheckBoxTypes
    
    private let checkBox = CheckBox()
    
    private let title = UILabel()

    // MARK: - Init

    public init(type: CheckBoxTypes) {
        self.type = type
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK - Private methods

private extension CheckBoxTitle {
    func setup() {
        addSubview(checkBox)
        checkBox.pinToSuperView(sides: .leftR, .centerYR)
        
        addSubview(title)
        title.pinToSuperView(sides: .rightR, .centerYR)
        title.pin(side: .left(10), to: .right(checkBox))
        title.text = type.title
    }
}
