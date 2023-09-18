//
//  PhoneSignInViewModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 17/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit

final class PhoneSignInViewConfigurator {

    // MARK: - Internal methods

    func configure(output: PhoneSignInViewModuleOutput) -> UIViewController {

        let viewModel = PhoneSignInViewViewModel(output: output)

        let view = PhoneSignInViewViewController(viewModel: viewModel)

        return view
    }

}
