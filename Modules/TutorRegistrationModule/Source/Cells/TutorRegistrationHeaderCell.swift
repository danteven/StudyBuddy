//
//  HeaderCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class TutorRegistrationHeaderCell: UICollectionViewCell {
    
    private let circleView = UIView()
    
    private let circleLabel = UILabel()
    
    private let mainLabel = UILabel()
        
    public override var isSelected: Bool {
        didSet {
            circleView.layer.borderColor = isSelected ?
            CommonAsset.Colors.mainPurple.color.cgColor :
            CommonAsset.Colors.grey.color.cgColor
            
            circleLabel.textColor = isSelected ?
            CommonAsset.Colors.mainPurple.color :
            CommonAsset.Colors.grey.color
            
            mainLabel.textColor = isSelected ?
            CommonAsset.Colors.mainPurple.color :
            CommonAsset.Colors.grey.color
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: [String: String], done: Bool? = nil) {
        circleLabel.text = model.keys.first
        mainLabel.text = model.values.first
        guard let done,
              done == true else { return }
        mainLabel.textColor = .black
        circleView.backgroundColor = .black
        circleLabel.textColor = .black
        
    }
}

private extension TutorRegistrationHeaderCell {
    
    func setup() {
        addSubview(circleView)
        circleView.pinToSuperView(sides: .topR, .leftR, .bottomR)
        circleView.layer.cornerRadius = 20
        circleView.setEqualSize(constant: 30)
        circleView.layer.borderColor = CommonAsset.Colors.grey.color.cgColor
        circleView.layer.borderWidth = 2
        
        circleView.addSubview(circleLabel)
        circleLabel.pinToSuperView(sides: .centerXR, .centerYR)
        circleLabel.textColor = CommonAsset.Colors.grey.color
        circleLabel.font = .systemFont(ofSize: 20)
        
        addSubview(mainLabel)
        mainLabel.pinToSuperView(sides: .centerYR, .rightR)
        mainLabel.pin(side: .left(8), to: .right(circleView))
        mainLabel.textColor = CommonAsset.Colors.grey.color
        mainLabel.font = .systemFont(ofSize: 20)
        
    }
    
    func bind() {
        
    }
}
