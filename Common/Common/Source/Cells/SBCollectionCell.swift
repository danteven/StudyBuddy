//
//  SBCollectionCell.swift
//  Common
//
//  Created by Shamil Mazitov on 05.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import UIKit
import Combine

public class SBCollectionCell: UICollectionViewCell {

    // MARK: - UICollectionViewCell properties
    
    public let id = UUID().uuidString
    
    
    public var deleteCellPublisher: CustomPublisher<String> {
        deleteCellSubject.eraseToAnyPublisher()
    }

    // MARK: - Private properties

    private var title: String?
    private let deleteCellSubject = CustomSubject<String>()
    private let label = UILabel()
    private let closeImageView = UIButton()
    private var cancellableSet = Set<AnyCancellable>()

    private var centerXConstraint: NSLayoutConstraint?

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    public func configure(with title: String) {
        label.text = title
        self.title = title
    }
}

// MARK: - Private methods

private extension SBCollectionCell {

    func setup() {
        contentView.addSubview(label)
        contentView.backgroundColor = CommonAsset.Colors.mainPurple.color

        contentView.layer.cornerRadius = 20
        label.pinToSuperView(sides: [.left(10), .top(10), .bottom(-10)])
//        centerXConstraint = label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//        centerXConstraint?.isActive = true
//        let rightAnchor = label.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -20)
//        rightAnchor.priority = .defaultHigh
//        rightAnchor.isActive = true

        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        contentView.addSubview(closeImageView)
        closeImageView.pinToSuperView(sides: [.right(-5), .centerYR])
        closeImageView.pin(side: .leftR, to: .right(label))
        closeImageView.setEqualSize(constant: 20)
        closeImageView.setImage(CommonAsset.Buttons.deleteButton.image, for: .normal)

    }
    
    func bind() {
        closeImageView.publisher(for: .touchUpInside)
            .withUnretained(self)
            .sink { view, _ in
                if let title = view.title {
                    view.deleteCellSubject.send(title)
                }
            }
            .store(in: &cancellableSet)
    }
}
