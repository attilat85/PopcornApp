//
//  UIViewController+Utility.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 22/08/2019.
//  Copyright © 2019 Halcyon Mobile. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Removes back bar button item title
    func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
