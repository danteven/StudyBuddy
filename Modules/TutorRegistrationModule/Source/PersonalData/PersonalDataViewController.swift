//
//  PersonalDataViewController.swift
//  StudyBuddy
//
//  Created by Shamil on 27/03/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import UIKit
import Combine
import Common

final class PersonalDataViewController: UIView {

    enum Constants { 
        static let personalData = "Личные данные"
        static let contacts = "Контакты"
        static let subtitlePersonal = "Эта информация нужна для регистрации и проверки анкеты"
        static let subtitleContacts = "Никто не будет видеть ваши контакты, они нужны для регистрации и для входа в личный кабинет"
    }

    // MARK: - Private Properties

    private let collectionView = SBTableView(needHeader: true)
    
    private let malePicker = UIPickerView()
    
    private let datePicker = UIDatePicker()
    
    private lazy var timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = DateFormatter.Style.long
        return timeFormatter
    }()
    
    private let purpleView = PurpleView()
    
    private let scrollView = UIScrollView()
    
    private let viewModel: PersonalDataViewModel

    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: PersonalDataViewModel) {
	self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController methods
    
    func bindTextfield(
        cell: TextFieldCell,
        indexPath: IndexPath
    ) {
        let actionSubject = PassthroughSubject<TextfieldCellAction, Never>()
        cell.setActionPublisher(actionSubject.eraseToAnyPublisher())
        
        cell.onSetTextPublisher
            .withUnretained(self)
            .sink { view, value in
                switch indexPath.section {
                case 1:
                    let type = view.viewModel.firstModel[indexPath.row]
                    view.viewModel.setPersonalData(type: type, value: value ?? "")
                case 2:
                    let type = view.viewModel.secondModel[indexPath.row]
                    view.viewModel.setPersonalData(type: type, value: value ?? "")
                default:
                    return
                }
                
            }
            .store(in: &cancellableSet)
        
    }
}

// MARK: - Private methods

private extension PersonalDataViewController {

    func setup() {
        addSubview(collectionView)
        collectionView.pinToSuperView()
        collectionView.register(TextFieldCell.self)
        collectionView.register(PurpleViewCell.self)
        collectionView.register(
            header: SBTableHeader.self,
            ofKind: .tableHeaderKind
        )
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
    @objc
    func changeDatePickerValue(sender: UIDatePicker) {
        let strDate = timeFormatter.string(from: sender.date)
//        dateTextField.setText(strDate)
    }

    func bind() {
        //bind funcions
    }

}

extension PersonalDataViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.tableSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.tableSections[section] {
        case .purpleView:
            return 1
        case .personalData:
            return viewModel.firstModel.count
        case .contacts:
            return viewModel.secondModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.tableSections[indexPath.section] {
        case .purpleView:
            let cell: PurpleViewCell = collectionView.dequeue(for: indexPath)
            cell.configure("Арефуллин")
            return cell
        case .personalData:
            let cell: TextFieldCell = collectionView.dequeue(for: indexPath)
            cell.configure(viewModel.firstModel[indexPath.row].placeholder, title: viewModel.firstModel[indexPath.row].title)
            bindTextfield(cell: cell, indexPath: indexPath)
            return cell
        case .contacts:
            let cell: TextFieldCell = collectionView.dequeue(for: indexPath)
            cell.configure(viewModel.secondModel[indexPath.row].placeholder, title: viewModel.secondModel[indexPath.row].title)
            bindTextfield(cell: cell, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch viewModel.tableSections[indexPath.section] {
        case .personalData:
            let header: SBTableHeader = collectionView.dequeue(
                for: indexPath,
                ofKind: .tableHeaderKind
            )
            header.configure(
                with: Constants.personalData,
                font: .boldSystemFont(
                    ofSize: 25
                ),
                subtitleText: Constants.subtitlePersonal
            )
            return header
        case .contacts:
            let header: SBTableHeader = collectionView.dequeue(
                for: indexPath,
                ofKind: .tableHeaderKind
            )
            header.configure(
                with: Constants.contacts,
                font: .boldSystemFont(
                    ofSize: 25
                ),
                subtitleText: Constants.subtitleContacts
            )
            return header
        case .purpleView:
            let header: SBTableHeader = collectionView.dequeue(
                for: indexPath,
                ofKind: .tableHeaderKind
            )
            header.configure(with: nil)
            return header
        }
    }
}
