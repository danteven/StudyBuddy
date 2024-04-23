//
//  SpecializationModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 11/04/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import UIKit

final class SpecializationConfigurator {

    // MARK: - Internal methods

    func configure(
        model: [String]?,
        output: SpecializationModuleOutput?
    ) -> UIView {

        let viewModel = SpecializationViewModel(
            model: model,
            output: output
        )

        let view = SpecializationViewController(viewModel: viewModel)

        return view
    }

}
