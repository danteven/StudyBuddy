//
//  TutorRegistrationConfigurator.swift
//  TutorRegistrationModule
//
//  Created by Shamil Mazitov on 27.03.2024.
//  Copyright © 2024 StuddyBuddy. All rights reserved.
//

import Foundation
import UIKit

final class TutorRegistrationConfigurator {

    // MARK: - Internal methods

    func configure(output: TutorRegistrationOutput) -> UIViewController {

        let viewModel = TutorRegistrationViewModel(output: output)

        let view = TutorRegistrationController(viewModel: viewModel)

        return view
    }

}
