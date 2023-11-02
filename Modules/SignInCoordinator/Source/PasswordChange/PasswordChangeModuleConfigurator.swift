//
//  PasswordChangeModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 26/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit

final class PasswordChangeConfigurator {

    // MARK: - Internal methods

    func configure(output: PasswordChangeModuleOutput) -> UIViewController {

        let viewModel = PasswordChangeViewModel(output: output)

        let view = PasswordChangeViewController(viewModel: viewModel)

        return view
    }

}
