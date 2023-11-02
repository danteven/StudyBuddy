//
//  RegistrationModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 12/10/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit

final class RegistrationConfigurator {

    // MARK: - Internal methods

    func configure(output: RegistrationModuleOutput) -> UIViewController {

        let viewModel = RegistrationViewModel(output: output)

        let view = RegistrationViewController(viewModel: viewModel)

        return view
    }

}
