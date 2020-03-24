//
//  RootFlow.swift
//  iOS Starter Project
//
//  Created by Andrei Matea on 02/09/2019.
//

import UIKit

final class RootComponent: Component<CoreComponent> {
    
    func mainComponent() -> MainComponent {
        return MainComponent(parent: self)
    }
}

class Component<Parent> {
    let parent: Parent

    init(parent: Parent) {
        self.parent = parent
    }
}

// this flow will hadle main flows change
// E.g after autentication content and back
class RootFlow {

    private weak var window: UIWindow?

    private let component = RootComponent(parent: CoreComponent())
    
    private var mainFlow: MainFlow?

    // MARK: - Lifecycle
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        mainFlow = MainFlow(component: component.mainComponent())
        setRoot(to: mainFlow?.start())
    }
    
    // MARK: - Set root
    
    fileprivate var root: UIViewController? {
        return window?.rootViewController
    }
    
    fileprivate func setRoot(to viewController: UIViewController?, animated: Bool = false) {
        guard let viewController = viewController else { return }
        
        guard root != viewController else { return }
        
        func changeRoot(to viewController: UIViewController) {
            window?.rootViewController = viewController
        }

        if animated {
            UIView.transition(with: window!, duration: AnimationDuration.normal, options: .transitionCrossDissolve, animations: {
                changeRoot(to: viewController)
            }, completion: nil)
        } else {
            changeRoot(to: viewController)
        }
    }
}
