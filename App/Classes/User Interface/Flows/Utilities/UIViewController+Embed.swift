//
//  UIViewController+Embed.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 29/07/2019.
//  Copyright © 2019 Halcyon Mobile. All rights reserved.
//

import UIKit

extension UIViewController {

    func displayContentController(content: UIViewController, in view: UIView? = nil) {
        let parentView = (view ?? self.view!)
        addChild(content)
        content.view.frame = parentView.bounds
        content.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parentView.addSubview(content.view)
        content.didMove(toParent: self)
    }

    func hideContentController(content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
}
