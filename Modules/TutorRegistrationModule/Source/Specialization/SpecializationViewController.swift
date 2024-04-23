//
//  SpecializationViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 11/04/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class SpecializationViewController: UIView {

    enum Constants { 
        static let goals = "По каким целям готовите учеников?"
        static let goalsSubtitle = "Расскажите с каким целями вы можете помочь наиболее эффективно, чтобы у вас было больше учеников , которым нужен репетитор именно с таким опытом"
    }

    // MARK: - Private Properties

    private lazy var collectionView = SBTableView(
        needHeader: true,
        itemSpacing: 20,
        sectionInset: NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 40,
            trailing: 0
        )
    )
    private let viewModel: SpecializationViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: SpecializationViewModel) {
	self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView methods


}

// MARK: - Private methods

private extension SpecializationViewController {

    func setup() {
        addSubview(collectionView)
        collectionView.pinToSuperView()
        collectionView.dataSource = self
        collectionView.register(SpecializationCell.self)
        collectionView.register(header: SBTableHeader.self, ofKind: .tableHeaderKind)
        
    }

    func bind() {
        //bind funcions
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }

}

extension SpecializationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SpecializationCell = collectionView.dequeue(for: indexPath)
        cell.configure(with: viewModel.model?[indexPath.row] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: SBTableHeader = collectionView.dequeue(for: indexPath, ofKind: .tableHeaderKind)
        header.configure(
            with: Constants.goals,
            font: .boldSystemFont(
                ofSize: 25
            ),
            subtitleText: Constants.goalsSubtitle,
            subtitleFont: .systemFont(ofSize: 16)
        )
        return header
    }
}
