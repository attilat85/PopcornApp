//
//  UIView+Layout.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 29/07/2019.
//  Copyright © 2019 Halcyon Mobile. All rights reserved.
//

import UIKit

extension UIView {
    
    static func autoLayout() -> Self {
        let view = Self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension UIView {

    func snap(into target: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        target.addSubview(self)
        topAnchor.constraint(equalTo: target.topAnchor).isActive = true
        rightAnchor.constraint(equalTo: target.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: target.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: target.leftAnchor).isActive = true
    }
}
