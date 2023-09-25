//
//  CodeSignInModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 21/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit

final class CodeSignInConfigurator {

    // MARK: - Internal methods

    func configure(output: CodeSignInModuleOutput) -> UIViewController {

        let viewModel = CodeSignInViewModel(output: output)

        let view = CodeSignInViewController(viewModel: viewModel)

        return view
    }

}
