//
//  ChooseSubjectCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 06.04.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common
import Combine

public class ChooseSubjectCell: UICollectionViewCell {
    
    enum Constants {
        static let placeholder = "Введите название предмета"
    }

    // MARK: - UICollectionViewCell properties
    
    var cellActionPublisher: CustomPublisher<CellActions> {
        cellActionSubject.eraseToAnyPublisher()
    }
    
    var isEdit: Bool = false {
        didSet {
            updateAppearance(isSelected: isEdit)
        }
    }

    // MARK: - Private properties

    private let cellActionSubject = CustomSubject<CellActions>()
    private var model = [String]()
    private var subjects = [String]()
    private let textField = StuddyBuddyTextField()
    private lazy var subjectsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
    private var bottomConstraint: NSLayoutConstraint?
    private var textfieldBottom: NSLayoutConstraint?
    private lazy var stack = UIStackView(arrangedSubviews: [textField, subjectsCollectionView])
    private var stackBottomConstraint: NSLayoutConstraint?


    private var cancellableSet = Set<AnyCancellable>()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    
    func configure(model: [String]) {
        self.model = model
        self.subjects = model
        subjectsCollectionView.reloadData()
    }

    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width, height: 30)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }
    
    func updateAppearance(isSelected: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.subjectsCollectionView.isHidden = !isSelected
            self.subjectsCollectionView.alpha = isSelected ? 1.0 : 0.0
            self.bottomConstraint?.isActive = isSelected
            self.textfieldBottom?.isActive = isSelected
            self.stackBottomConstraint?.constant = isSelected ? 0 : -50
            self.stack.layoutIfNeeded()
        }
//        bottomConstraint?.isActive = isSelected
//        textfieldBottom?.isActive = !isSelected
    }
}

// MARK: - Private methods

private extension ChooseSubjectCell {

    func setup() {
        
//        contentView.addSubview(textField)
//        textField.pinToSuperView(sides: .left(16), .right(-16), .topR)
        textField.placeholder = Constants.placeholder
        textField.setDemission(.height(60))
        textField.delegate = self
        textField.isEnabled = true
//        textfieldBottom = textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        textfieldBottom?.isActive = true
        
        contentView.addSubview(stack)
        stack.pinToSuperView(sides: .left(16), .right(-16), .topR)
        
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 5
        subjectsCollectionView.dataSource = self
        subjectsCollectionView.delegate = self
        subjectsCollectionView.register(SubjectsTableCell.self)
        textfieldBottom = subjectsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        textfieldBottom?.isActive = false
        subjectsCollectionView.showsVerticalScrollIndicator = false
        subjectsCollectionView.isHidden = true
        bottomConstraint = stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        bottomConstraint?.priority = .defaultHigh
        stackBottomConstraint = stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200)
        stackBottomConstraint?.isActive = true
//        bottomConstraint = stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        bottomConstraint?.isActive = false
    }
    
    func search(text: String) {
        Task(priority: .high) { [weak self] in
            guard let self else { return }
            let updText = text
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
            
            let filter: (String?) -> Bool = { subject in
                
                guard let subject else { return false }
                
                return subject
                    .lowercased()
                    .contains(updText)
            }
            let models = subjects.compactMap{
                if filter($0) {
                    return $0
                } else {
                    return nil
                }
            }
            self.model = models
        }
    }
    
    func bind() {
        textField.onSetTextPublisher
            .withUnretained(self)
            .sink { cell, text in
                guard let text,
                !text.isEmpty else {
                    cell.model = cell.subjects
                    cell.subjectsCollectionView.reloadData()
                    return
                }
                cell.search(text: text)
                cell.subjectsCollectionView.reloadData()
            }
            .store(in: &cancellableSet)
    }
}

extension ChooseSubjectCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellActionSubject.send(.choose(model[indexPath.row]))
        textField.endEditing(true)
    }
}

extension ChooseSubjectCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SubjectsTableCell = collectionView.dequeue(for: indexPath)
        cell.configure(with: model[indexPath.row])
        return cell
    }
}

extension ChooseSubjectCell: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        isEdit = true
//        UIView.animate(withDuration: 0.3) {
//            self.subjectsCollectionView.isHidden = false
//            self.cellActionSubject.send(.updateConstraints(true))
//            self.layoutIfNeeded()
//        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        isEdit = false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
