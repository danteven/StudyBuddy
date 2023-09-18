//
//  Coordinator.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.07.2023.
//


import UIKit

public protocol Coordinator: AnyObject {

    /// Start new coordinator from created navigation controller
    func start()

}
