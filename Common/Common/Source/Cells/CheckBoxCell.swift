//
//  CheckBoxCell.swift
//  Common
//
//  Created by Shamil Mazitov on 04.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Combine

public class CheckBoxCell: UICollectionViewCell {
    
    public var tapCheckBoxTypePublisher: CustomPublisher<(CheckBoxTypes, Bool)> {
        tapCheckBoxTypeSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private properties
    
    private let tapCheckBoxTypeSubject = CustomSubject<(CheckBoxTypes, Bool)>()
    private let checkBox = CheckBox()
    private let titleLabel = UILabel()
    private var type: CheckBoxTypes?
    private var cancellableSet = Set<AnyCancellable>()
        
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
    
    public func configure(type: CheckBoxTypes) {
        titleLabel.text = type.title
        self.type = type
    }
}

// MARK: - Private methods

private extension CheckBoxCell {
    func setup() {
        contentView.addSubview(checkBox)
        checkBox.pinToSuperView(sides: .left(16), .bottomR, .topR)
        checkBox.setEqualSize(constant: 20)
        
        contentView.addSubview(titleLabel)
        titleLabel.pinToSuperView(sides: .rightR, .centerYR)
        titleLabel.pin(side: .left(15), to: .right(checkBox))
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .black
    }
    
    func bind() {
        checkBox.onTapActionPublisher
            .map{ bool in (self.type ?? .adult, bool) }
            .weakSubscribe(tapCheckBoxTypeSubject)
            .store(in: &cancellableSet)
    }
}
