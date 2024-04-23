//
//  CodeSignInModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 21/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit
import Common

final class CodeSignInConfigurator {

    // MARK: - Internal methods

    func configure(
        name: String? = nil,
        type: RegistrationType? = nil,
        output: CodeSignInModuleOutput
    ) -> UIViewController {

        let viewModel = CodeSignInViewModel(
            name: name,
            type: type,
            output: output
        )

        let view = CodeSignInViewController(viewModel: viewModel)

        return view
    }

}
