//
//  RegistrationCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 28.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

class RegistrationCell: UICollectionViewCell {

    private var stepView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: RegistrationCellModel) {
        stepView?.removeFromSuperview()
        stepView = RegistrationCellFactory.getView(for: model)
        contentView.addSubview(stepView!)
        stepView?.pinToSuperView()
    }


}
