//
//  NavigationFlow.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 08/10/2018.
//  Copyright © 2018 Halcyon Mobile. All rights reserved.
//

import UIKit

// UINavigationController subclass to keep strong reference to the flow
class FlowNavigationController<Flow: NavigationFlow>: UINavigationController {
    // Keeps reference of the flow until the navigation controller
    // disappears from the view hierarchy.
    var flow: Flow?
}

protocol NavigationFlow: Flow where Scene == UINavigationController {

    /// Reference to the navigation controller. Should be declared weak.
    var navigationController: UINavigationController? { get set }

    /// Returnt the first View Controller.
    ///
    /// - Returns: view controller instance.
    func firstScene() -> UIViewController
}

// MARK: - Convenience

extension NavigationFlow {

    func start() -> Scene {
        let navigationController = FlowNavigationController<Self>(rootViewController: firstScene())
        navigationController.flow = self
        defer { self.navigationController = navigationController }
        return navigationController
    }
}

extension NavigationFlow {

    func push(onto navigationController: UINavigationController) {
        navigationController.pushViewController(firstScene(), animated: true)
        self.navigationController = navigationController
    }

    func setRoot(onto navigationController: UINavigationController) {
        navigationController.setViewControllers([firstScene()], animated: false)
        self.navigationController = navigationController
    }
}
