//
//  Router.swift
//  StudyBuddy
//
//  Created by Shamil Mazitov on 17.09.2023.
//

import Foundation
import UIKit

public protocol Router: AnyObject {
    
    /// ATENTION: IT"S ONLY FOR CREATE MOCK FLOW!!!!!!!!!!!!!
    var MOCKtopViewController: UIViewController? { get }

    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func fullScreenPresent(_ module: Presentable?)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, hideTabBar: Bool)

    /// Animate pop for controllers in navigationController
    func popModule()
    func popModule(animated: Bool)
    func pop(to module: Presentable?)
    func pop(to module: Presentable?, animated: Bool)

    /// Animate pop to root for controllers in navigationController
    func popToRoot()
    func popToRoot(animated: Bool)
    func popModule(animated: Bool, completion: @escaping EmptyClosure)

    func dismissModule(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func dismissAll(animated: Bool, completion: (() -> Void)?)

    func setNavigationControllerRootModule(_ module: Presentable?, animated: Bool, hideBar: Bool)
    func setRootModule(_ module: Presentable?)

    func setTab(_ index: Int)
    
    /// add controller to current tab bar
    func addToTabBar(_ module: Presentable)
    func showMockAlert(text: String)

}
