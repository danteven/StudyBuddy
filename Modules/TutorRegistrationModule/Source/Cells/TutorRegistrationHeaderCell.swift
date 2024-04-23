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
            circleView.tintColor = isSelected ?
            CommonAsset.Colors.mainPurple.color :
            CommonAsset.Colors.darkGrey.color
            
            circleLabel.textColor = isSelected ?
            CommonAsset.Colors.mainPurple.color :
                .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()
    
}

private extension TutorRegistrationHeaderCell {
    
    func setup() {
        addSubview(circleView)
        circleView.pinToSuperView(sides: .topR, .leftR, .bottomR)
        circleView.layer.cornerRadius = 15
        circleView.setDemission(.height(30))
        circleView.tintColor = CommonAsset.Colors.darkGrey.color
        
        circleView.addSubview(circleLabel)
        circleLabel.pinToSuperView(sides: .centerXR, .centerYR)
        circleLabel.textColor = .black
        circleLabel.font = .systemFont(ofSize: 13)
        
        addSubview(mainLabel)
        mainLabel.pinToSuperView(sides: .centerYR, .rightR)
        mainLabel.pin(side: .left(8), to: .right(circleLabel))
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 13)
        
    }
    
    func bind() {
        
    }
}
