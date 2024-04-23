//
//  PersonalDataModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 27/03/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import UIKit

final class PersonalDataConfigurator {

    // MARK: - Internal methods

    func configure(output: PersonalDataModuleOutput? = nil) -> UIView {

        let viewModel = PersonalDataViewModel(output: output)

        let view = PersonalDataViewController(viewModel: viewModel)

        return view
    }

}
