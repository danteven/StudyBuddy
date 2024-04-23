//
//  RegistrationModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 12/10/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Common

final class RegistrationConfigurator {

    // MARK: - Internal methods

    func configure(
        type: RegistrationType,
        output: RegistrationModuleOutput
    ) -> UIViewController {

        let viewModel = RegistrationViewModel(
            type: type,
            output: output
        )

        let view = RegistrationViewController(viewModel: viewModel)

        return view
    }

}
