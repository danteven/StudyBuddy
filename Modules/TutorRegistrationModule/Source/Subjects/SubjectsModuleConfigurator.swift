//
//  SubjectsModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 04/04/2024.
//  Copyright © 2024 StudyBuddy. All rights reserved.
//

import UIKit

final class SubjectsConfigurator {

    // MARK: - Internal methods

    func configure(output: SubjectsModuleOutput?) -> UIView {

        let viewModel = SubjectsViewModel(output: output)

        let view = SubjectsViewController(viewModel: viewModel)

        return view
    }

}
