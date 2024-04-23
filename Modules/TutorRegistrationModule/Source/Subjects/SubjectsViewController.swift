//
//  SubjectsViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 04/04/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class SubjectsViewController: UIView {

    enum Constants { 
        static let students = "С какими учениками работаете?"
        static let subjects = "Какие предметы преподаёте?"
        static let subjectsSubtitle = "Можете выбрать несколько предметов, по которым готовы обучать или помогать с учебными работами"
    }

    // MARK: - Private Properties

    private let collectionView = SBTableView(
        needHeader: true,
        itemSpacing: 20,
        sectionInset: NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 40,
            trailing: 0
        )
    )

    private let viewModel: SubjectsViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: SubjectsViewModel) {
	self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCheckBox(type: CheckBoxTypes) -> CheckBoxTitle {
        CheckBoxTitle(type: type)
    }


}

// MARK: - Private methods

private extension SubjectsViewController {

    func setup() {
        addSubview(collectionView)
        collectionView.pinToSuperView(sides: .leftR, .rightR, .topR)
        collectionView.setDemission(.height(800))
        collectionView.register(CheckBoxCell.self)
        collectionView.register(SubjectsCell.self)
        collectionView.register(header: SBTableHeader.self, ofKind: .tableHeaderKind)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
    }

    func bind() {
        //bind funcions
    }

}

extension SubjectsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return CheckBoxTypes.allCases.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: CheckBoxCell = collectionView.dequeue(for: indexPath)
            cell.configure(type: CheckBoxTypes.allCases[indexPath.row])
            cell.tapCheckBoxTypePublisher
                .withUnretained(self)
                .sink { view, model in
                    let(type, bool) = model
                    view.viewModel.tappedCategory(type: type, isSelected: bool)
                }
                .store(in: &cancellableSet)
            return cell
        default:
            let cell: SubjectsCell = collectionView.dequeue(for: indexPath)
            let viewModel = SubjectsCellViewModel(
                model: viewModel.model
            )
            cell.configure(viewModel: viewModel)
            cell.changeInModelPublisher
                .withUnretained(self)
                .sink { view, subject in
                    view.viewModel.changeSubjects(type: subject)
                }
                .store(in: &cancellableSet)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let header: SBTableHeader = collectionView.dequeue(for: indexPath, ofKind: .tableHeaderKind)
            header.configure(with: Constants.students,
                             font: .boldSystemFont(ofSize: 25)
            )
            return header
        default:
            let header: SBTableHeader = collectionView.dequeue(for: indexPath, ofKind: .tableHeaderKind)
            header.configure(with: Constants.subjects,
                             font: .boldSystemFont(ofSize: 25),
                             subtitleText: Constants.subjectsSubtitle)
            return header
        }
    }
    
}

extension SubjectsViewController: UICollectionViewDelegate { }

