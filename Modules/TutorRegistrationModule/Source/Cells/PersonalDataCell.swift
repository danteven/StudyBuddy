//
//  PersonalDataCell.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 29.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit
import Common

public class PersonalDataCell: UICollectionViewCell {
    
    private let secondNameTextfield = StuddyBuddyTextField()
    
    private let nameTextField = StuddyBuddyTextField()
    
    private let surnameTextfield = StuddyBuddyTextField()
    
    private let maleTextField = StuddyBuddyTextField()
    
    private let dateTextField = StuddyBuddyTextField()
    
    private let malePicker = UIPickerView()
    
    private let datePicker = UIDatePicker()
    
    private lazy var timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = DateFormatter.Style.long
        return timeFormatter
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
      
    }
}

private extension PersonalDataCell {
    
    func setup() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(changeDatePickerValue(sender:)), for: .valueChanged)
        
    }
    
    @objc
    func changeDatePickerValue(sender: UIDatePicker) {
        let strDate = timeFormatter.string(from: sender.date)
        dateTextField.setText(strDate)
    }
    
    func bind() {
        
    }
}
