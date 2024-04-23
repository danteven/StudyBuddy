//
//  SubjectsTableCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 05.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

public class SubjectsTableCell: UICollectionViewCell {

    // MARK: - UICollectionViewCell properties

    // MARK: - Private properties

    private let label = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    public func configure(with title: String) {
        label.text = title
    }
}

// MARK: - Private methods

private extension SubjectsTableCell {

    func setup() {
        contentView.addSubview(label)

        label.pinToSuperView(sides: .left(16), .top(5), .bottom(-5), .rightR)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black

    }
}
