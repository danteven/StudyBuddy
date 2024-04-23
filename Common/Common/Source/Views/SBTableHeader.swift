//
//  SBTableHeader.swift
//  Common
//
//  Created by Shamil Mazitov on 30.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation

import UIKit

public final class SBTableHeader: UICollectionReusableView {
    
    // MARK: - Private properties
    
    private let title = UILabel()
    private let subtitle = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func configure(
        with text: String?,
        font: UIFont = .boldSystemFont(ofSize: 20),
        subtitleText: String? = nil,
        subtitleFont: UIFont = .systemFont(ofSize: 16)
    ) {
        title.text = text
        title.font = font
        subtitle.text = subtitleText
        subtitle.font = subtitleFont
    }
}

// MARK: - Private methods

private extension SBTableHeader {
    func setup() {
        addSubview(title)
        title.pinToSuperView(sides: .topR, .left(16), .right(-16))
        title.textColor = .black
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        addSubview(subtitle)
        subtitle.pinToSuperView(sides: .left(16), .rightR, .bottom(-20))
        subtitle.pin(side: .top(10), to: .bottom(title))
        subtitle.textColor = CommonAsset.Colors.grey.color
        subtitle.numberOfLines = 0
        subtitle.lineBreakMode = .byWordWrapping
    }
}
