//
//  InstructionsModuleConfigurator.swift
//  StudyBuddy
//
//  Created by Shamil on 29/09/2023.
//  Copyright © 2023 StudyBuddy. All rights reserved.
//

import UIKit

final class InstructionsConfigurator {

    // MARK: - Internal methods

    func configure(output: InstructionsModuleOutput) -> UIViewController {

        let viewModel = InstructionsViewModel(output: output)

        let view = InstructionsViewController(viewModel: viewModel)
        view.modalPresentationStyle = .overCurrentContext

        return view
    }

}
