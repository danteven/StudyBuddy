//
//  ProgressHeaderView.swift
//  Common
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

open class ProgressHeaderView: UIView {

    // MARK: - Init
    
    private let model = [
        ["1" : "Личные данные"],
        ["2" : "Предметы"],
        ["3" : "Специализация"],
        ["4" : "Место занятий"],
        ["5" : "Образование"],
        ["6" : "Опыт"],
        ["7" : "Сертификаты"],
        ["8" : "Расписание"],
        ["9" : "Стоимость"],
        ["10" : "Профиль"]
    ]
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    public init() {
        super.init(frame: .zero)
        setup()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    /// add header to superview and set constraints
    public func addHeader(to view: UIView) {
        view.addSubview(self)
        pinToSuperView(sides: [.leftR, .rightR])
        setDemission(.height(30))
    }

}

private extension ProgressHeaderView {
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 40)
        return layout
    }
    
    func setup() {
        addSubview(collectionView)
        collectionView.pinToSuperView()
        collectionView.register(TutorRegistrationHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ProgressHeaderView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TutorRegistrationHeaderCell = collectionView.dequeue(for: indexPath)
        cell.configure(model: model[indexPath.row])
        return cell
    }
}

extension ProgressHeaderView: UICollectionViewDelegate {
}
